Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FA7B7E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbjJDLky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjJDLkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:40:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041EDA1;
        Wed,  4 Oct 2023 04:40:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948ihJu005633;
        Wed, 4 Oct 2023 11:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VUSeSoj8WbGnp2j84djlZg36ucFsEkd3CFqJFLI5EpI=;
 b=vhXPIYmHIi2aH7p7lgKbgHeikGa+8W9p3UJPI396KYlzWZLcFrkqPz0UQ73VornlFB6Q
 cvLxSnNbXZYhtmPGge+rH5rb9NaIGE/KvPRp4kuFY6VpmtSd+8zpKaWYC+1ss9Xe7uk0
 /sRABtQaFVK9nI+dMzLv+jYUktmT07eW3eIadW/Ikog16nzYmIb6+a3YKrhDsF9cMbfj
 ahhWdIBwAc3rSNDlMWnr+fp6Y7ds9uvJm02+vYB5DPNCoG8ejGLvIzzQP/0Mo7caOlGX
 vi1R7N3NoX0JZqa6I2oNvJ0tEnYVKnyPISAk5ZpGp8XCxyVz2bpI7MQiTXvIYbXUB6pk +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3eeukm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 11:40:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394BDtw1005830;
        Wed, 4 Oct 2023 11:40:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47fyd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 11:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axLv0N5VlMBh+jP4mDUhRc6lKj9/xc5VBjT5sVGeA85Hjf9PctBx1w7mFv3k7kId/Ot+UMiOo1UvRnwfVhH8IiYERPqJbf8PqWf6x24hb+CS7LK1iEqAAXozCokzOyeV8Gt+FSlfnkY9qqnw/wdCTXEgCCF+N74tulJTR3Q54qjEuCvt5tq1CYVJxrZl9Imnh7AMiZyX2EqIoExaxat1JAWtwEGXehYCZJOdHtRR/W+SzX/EK2z+VWOFBhHCBeoZw0eT+ribEZgNXjVkuRC0sGDIOnT8Y/KJcScuGKFAXRTk1n0V5VKfpzPcpmoKg3xvdAO7lWpTBtt6DmtFFE0bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUSeSoj8WbGnp2j84djlZg36ucFsEkd3CFqJFLI5EpI=;
 b=WcrGyhKGSm9z2EEHwxgDORO0L4FHPh+k5dgKF/z7YsRrO758cckMGOZ0OaMuX78IHaZyXUnlstn6V4fOQb3Dml6BaCv0Ia9yF2LVwoDSWk8LcxIQwHESjh4NY4dbQPnaLo25qgSaHbXel0EWcP7Wvsng37H+RGr1IQ/Toi6ykBz1cqznG+z9cRmcKFnR3THjkC8fea3N40unZDv9Uu6lgr2baicuP8vwXVa4D6I+QgMPq6rRXOHrdiLlYG6bLj/PlqDlzcH2oRYbD1TLfU2tl0iin6XTuA5CwKjEX1mh8qTeAjbadtzjxM2wWbz2zXZFdyb/j8XNtqz6R0Z+PrzgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUSeSoj8WbGnp2j84djlZg36ucFsEkd3CFqJFLI5EpI=;
 b=AYDY+aibyzDH7j2KZzFSow6mBHlmfsqmKm5pv0TIT2wcsmXjFJ5VkqGYHdEFcZyk8qNTP2PaYU8C/JBjE/8b9V/GJwoHyT/vct5/iO4BYhmRViztTs5FSw5g9DFAiRcGoGan25nrfJP1BTkrIFjBfxIi25Y27krDyAxCLzgq4bc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6917.namprd10.prod.outlook.com (2603:10b6:8:134::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Wed, 4 Oct
 2023 11:40:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 11:40:21 +0000
Message-ID: <3825f45c-9321-45f1-384e-384baf6c62f8@oracle.com>
Date:   Wed, 4 Oct 2023 12:40:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/21] block: Add checks to merging of atomic writes
To:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
References: <20230929102726.2985188-10-john.g.garry@oracle.com>
 <202309302100.L6ynQWub-lkp@intel.com>
 <20231002225048.GA558147@dev-arch.thelio-3990X>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231002225048.GA558147@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: a68aca5d-6fcc-43f4-92b8-08dbc4ceb0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c30WEyiYCx06Dc0TB9wx4XJhFM1UVWW6K8aVXM8sEx4zNsUz/w4NKpHYeqcvVlb1xHNZdXE+gQlbDIp89ugTxy+esC5FNADlRD+3FuXlZoF6i9Wzk4YtUM6hiF/+AeDvQjOG1JlBdecLdBOH7Wit/IbUZNT57CmUXuVtOZKNWMizlKH6LEO2DPwNLJBiS79+nnXR+zJxCdzM+2lxLe+3HgPbMv178x2nCfQLz7GAwiAwR28W+hv/TtXyC7zc5/p3w5lLqlv7xhOeMUHwbJQJjX3+QOwlyO7usovs7o5R+1k5AZTnFYq7qZpT3URovrVVlpsiXS7g1D5AR0yYEWdXktVVPm8G4vsrVG/HpJW39r643FZ3B7rUl0Z1SA5EmIp8KT8ilH037kopNvkKvUENYOvdeMhPtH730M+IHUo15TK4P+Lw3S+TEgHjGqVp2iwQnVygM0imDG4Rt493xCgR0nxq9utfK3e9Izkbjohc8x3fVU0qGyRcRLrdpAc7sEkWuTNaUWZXfU7x89pq1ntMtiLblo33JyQTTPWQCRTyoqIenHlRQ98QMutOeL0y5Sll5zucW7gXLcr7Rws2qR0dyJzef7zmTlW6iQt3R6LEnq8bLpGmwnbSFNDybq75vBhH3BDdjd+HeYBcgnNDISGDog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(6666004)(6486002)(36916002)(6506007)(6512007)(478600001)(53546011)(38100700002)(31696002)(86362001)(2906002)(7416002)(83380400001)(26005)(2616005)(66946007)(36756003)(316002)(66556008)(66476007)(41300700001)(5660300002)(110136005)(4326008)(8936002)(8676002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdlRElmeEc0WUZVOHVkNTNFZG5YSGNNVjY0TDJoQk0yNUVHd3liWThERDZw?=
 =?utf-8?B?OVgydVJwU2EwZENQeTFOOWIwUEhFMWNDcUVhcTExcmxaNkRTWWsrKzNQUjdq?=
 =?utf-8?B?ck5SeTVySS9ZUkM3cHc2SGZvc3VDQVVBTkhnWDNidEgxUk9saHRIYTJ0dTNV?=
 =?utf-8?B?ME4vM2tPVi8yaGhXZjFsRGRHUE4zTFhGUTVKdWxocWhoVnFKdGN4RGlEZzdk?=
 =?utf-8?B?VVBkM2orZmY1ci9XdHFibTE4SytJbk9yakdCNzNOZ3RXWDRMbjllS1NJQmdB?=
 =?utf-8?B?QTNVQlFaVlZVa2FIU2FLNThScXRaUGZXV2hGQkZPWWpYZTZEKy9OVHhsT3RE?=
 =?utf-8?B?cmxLUW9tVGxzYmJ4NDlJaS9VSk5rRlgyczNTYlp6WWt5VmljTHZBZnFzWEk5?=
 =?utf-8?B?RmdtaGttZ3hSMmVoOTJqcWpKeURKc1FpOEhER2o1cGtnTVFUcVVFV05SazVE?=
 =?utf-8?B?UE5uYzdwU3Jmc2dGTGVSRFpKQ2JPWTFBTDR2TkZiRDRlTkZZMHZ6TzZuYU1l?=
 =?utf-8?B?dGM0OTNWRVpYZkxNLzBlb1lYV0NlTHU2ZkdwL2Vpc2xrUUJlTHRhbEc1VTBY?=
 =?utf-8?B?MndJejZqYTFuRWtXNk9JRjRWbFA5TUZzQ2V2bEdKYldaZFpYUVMzSDIrUDlk?=
 =?utf-8?B?Z3RoK290d04vYmYzSWluUFFGaWhtbUZGcmtObjd1TmYxdUFHTzNES1JTMEg5?=
 =?utf-8?B?WmFDWTBYdHJEZHNxdHRRWXdUNHozajBPTkNTa3JtUmptK0JZZXVMQ2VIajh5?=
 =?utf-8?B?NXFHSzZIYmdXaFNRTHBVYUtaM01TMTZFL2ZoTEUxMEJPcDJveFY3QnRPOWMr?=
 =?utf-8?B?Qys1b01iQ0pWR0xoL0JxaE9UUTlJTTVZWW5uSUIwbk5HQmpqOHF6eWJiNDM1?=
 =?utf-8?B?Z2htTkJDUVpLYzdvQkc4TlFsYll2MjB6V3RoVkIzWXpjWlhiWTVOdjFTWmNw?=
 =?utf-8?B?cWdDa2JLTXFyQzFxR1lFN3hOLy91V1cybU1tVmhpNWZDVlVBMmE2MFBSNlhJ?=
 =?utf-8?B?QmlZVGZIcmJLN0dsSUpERmdnb3h5YkdaaEoySlNjdXVQVmxSUHVsaVBUM01N?=
 =?utf-8?B?SC9Jb0FjTVhLM1VOWU9qUzJ4WEFwb2pwb3V4T2pBQ0lJMkR6YVdmbzBVTTNs?=
 =?utf-8?B?a0pHWFZmcU15bWxlSFhFcVFMODZDRmVMNGRDQmlqQnRWb0hLbXh5NnF5L3Bx?=
 =?utf-8?B?KzlNRUlSWjJiem1sMzlCckgwSko5ajM5TXlMYWZWNStiSHU2bFM3S1NldjVI?=
 =?utf-8?B?NTZKSGZEbzZocHBmNWg5OGlQdWMxbVIyaE9uVm84MnZieDJBSWxxR0E0Zk56?=
 =?utf-8?B?Y0g0UFkyS0FVa0Z6dHkydnJMN1p2cDJucmszVlI0RjQrS3pPMTE1cXZJT3VH?=
 =?utf-8?B?T2l3Qm45emhGUGFsQW9mQk5pZFM4dm1tVnJNZURhd2FVQ2kySTJPZjM0L1dn?=
 =?utf-8?B?N3RsM1cwZktOTTlENDdBcmxMejNZcmQ2NEwzdW0xclZjUzF2dnFHL0ZQSEEr?=
 =?utf-8?B?M1pDM2tnSFg5M2ZNdkg4clFCN1FXSmxMc1NuRkIrYXJFYlNqZnljalNIQUdK?=
 =?utf-8?B?dWh1c0tkUWxjRmNHZFdRTGkzd1c5azU5b0cvNnBXSTkraG1KZkZRNnN2cGda?=
 =?utf-8?B?MStXcW1HNjhhTkxIVHNCcXZGUlB0WG5ENmpUeStGcEoySEFJdFhYenBKaUxU?=
 =?utf-8?B?dWVrcHVLOHp3bWNmWStSVkQ5UE1zL3hEd0x3bWhTUnRJR2R1RUs5YWQvOEkw?=
 =?utf-8?B?eVRXV3QzMmtFUFAzOG0rOExXSWQwb01LOENNcUM4ZWFCeWhsbSswV3A1ZDY3?=
 =?utf-8?B?STBQMlpOVk5Na0NjVjJsdWc3dDRyQjBJdGJSa2VxU0tNNEh6S1A2Nm1RRWJO?=
 =?utf-8?B?aVBqcTRON0cvYzZuR0lvcXdFYk9MU2dlazVVN3BtZ3FKZmlsdHRCWXJuREo1?=
 =?utf-8?B?bElNRnJwaGFYZkF5MXZPY3NjK0x0NFRjS1hlVWZCNm9rK3dpSjArMmt5amNk?=
 =?utf-8?B?dWhJa2Ntb2hUTHBBMnc5MDAvemdlZzJwY0dvemdOL3hyaWs4dHBmN1FEdGU4?=
 =?utf-8?B?SmlWYmV6cnB0dG5PT1BXRDJNYjVLSkV2dXBRWFI5NStIMDJpR3VlaGlLTjlL?=
 =?utf-8?Q?M2eKlkQtjfaA2PVCXgJin6A8k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTR3aGc3bXljNHZYYlRGRG85dDd3OTZyN1BtcmkzdzNJeWdSV3BQd0lST2pk?=
 =?utf-8?B?NHdGRXNKdVUrSjVWNFNKVjk1MjZ5UnMrdVQrYnZ2VW5LQnZVSkNiSXorQ1hx?=
 =?utf-8?B?c0VZalB6bHZPU3o5bDlHYWFnMVV1elBuSFB5SzFraWhVSUYzR1MySjkxQnFu?=
 =?utf-8?B?MmlXR0JrMlFBV21tUDM5VDVhblRIa09vWm5kcmE3OTZWM2E5T2NYVXptYUtN?=
 =?utf-8?B?aFJNcDNHRTc3SGJJNmtTeFpKSWovTnRtK1hsaGtTcmJqTG9YTWZWWkU0L3lo?=
 =?utf-8?B?cVVLWGVyd2FPSHlSOFNXV3hickpBMEF1Nm5YSHZ6aytrTFZnU3IxT2VGZHVS?=
 =?utf-8?B?cjVzcXY1OGZJVENvUTZRb25FQkdpQllYM2M1eHc2VW1xWS9vQlFSSGw1U1VL?=
 =?utf-8?B?ZnJzU2ZmSzF1aVhUTHZMTytZeUtqRjJCWlZVdVRTYk5nMlFEQ0FqRFdLRUFw?=
 =?utf-8?B?ODNrenNCbVptMmFBVEJ4WFdQWENUNkpPM0kvckpaZVFzZmFnbmdmYk44dk9n?=
 =?utf-8?B?K2IzbG8rR3Boeld4NFZ4U3hYM2dZdnkwM0g1aElkQkpwejFxbk4xR0dOeWNJ?=
 =?utf-8?B?MU5rVWhZaENsS2plcC9sQ0Q2NExlMmY5MGxSems2bEFtd1BBWFNQRWhsOWV2?=
 =?utf-8?B?RG9IZUpoTU5HVE5zOWljMUFuelNpd3kyVUlWTzZza3pueGNFSVRGTng1TXBR?=
 =?utf-8?B?cUlid0ZrSW05NUk1b01jK3RDZUtmRE9HT3FteXZkYXI3OGQ1L0NBdnN1c2t3?=
 =?utf-8?B?cTd6YWlWN0xaZHdwbWh5cWNGeTh3UmFvNUZ5Wlc5a1FkY0s4b1VkM3MwZmFi?=
 =?utf-8?B?cEFjQkJHZ1Z4am9QZUtXbWJVNndiK0RHSmFOMVpPTDg3OGJXNXRpenBQZnNn?=
 =?utf-8?B?a0NuVUN4Tk1iamc1UnVpMGNQbm84QUEwSXFKTlkyY0N3RFRZSEJxUmJSV2tW?=
 =?utf-8?B?NkNseEhvanZydTltUSs1TXRtNnNpdzltd2xSVnE4Z3dTY3NuMFdGQWhILzhY?=
 =?utf-8?B?MURUaDh3ZXhzbCs3NllGZCs0UkpPL0JONkx5YTdVMDFrNzlhblV0UnY3anJV?=
 =?utf-8?B?ZGF5VXRneWQ5V0ZPL1FTZGswMU1IUnZrUWRSa2VXL3VQdGZ3Q0pHUlhqWDJh?=
 =?utf-8?B?THNqb21zT2VFN0VNT2hyRFhES0ltOFVjUTd4a1RBRUNGNHM0NDdLMGVLOE9k?=
 =?utf-8?B?dXlMY2dIMHpzRlFENkp1ditFdjFubUxBWjhrbW5PUWFiS2NTZjd3RG5zZi9V?=
 =?utf-8?B?emEvZFkwM1NnTXhkZEZGdzdNSmgrSWtHYUVKWVpFRS9GTDRkOWk3blU1WGk2?=
 =?utf-8?B?eXNJRmdvTG9zUlZ6K0ZSay81Y04wRzhOVG41UHFMRFltb2pVRWtUajBiY3F6?=
 =?utf-8?B?YmV1QUZpTS9nTVJzYldVODZxRGRZd0VsdkE4QU40WUNEeHkvdFR1b1lpQ1Ry?=
 =?utf-8?B?bkNQZE1UaTRmd2VBU1g1SFZ5V3dZL2JoTDZJODIxa3RJYVZ6WGpaL1BLZnZW?=
 =?utf-8?B?WWR4WEhJWlFmSVp2WnZSa2dybHV2VFhSUU5tS2p5L0x3ZmxTZUt4bHVJY2JK?=
 =?utf-8?B?eHdDZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68aca5d-6fcc-43f4-92b8-08dbc4ceb0d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:40:21.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI8oZdaX8jzW77FjJC0KN46ldKxsHWeM8Dn0F1D1YZChFvvYimku4xvLD7vODzxS7pXZij3C3AeD8ebjkOP0DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_03,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040084
X-Proofpoint-ORIG-GUID: lSIZl8vuH7V4-57HMGyn3e2Iw6PObCAW
X-Proofpoint-GUID: lSIZl8vuH7V4-57HMGyn3e2Iw6PObCAW
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/10/2023 23:50, Nathan Chancellor wrote:
>>>> ld.lld: error: undefined symbol: __moddi3
>>     >>> referenced by blk-merge.c
>>     >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
>>     >>> referenced by blk-merge.c
>>     >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
>>     >>> referenced by blk-merge.c
>>     >>>               block/blk-merge.o:(bio_attempt_front_merge) in archive vmlinux.a
>>     >>> referenced 3 more times
> This does not appear to be clang specific, I can reproduce it with GCC
> 12.3.0 and the same configuration target.

Yeah, I just need to stop using the modulo operator for 64b values, 
which I had already been advised to :|

Thanks,
John
