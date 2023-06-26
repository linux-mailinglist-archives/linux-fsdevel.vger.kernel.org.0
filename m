Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987EE73E6EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjFZRuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjFZRue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:50:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7FE54;
        Mon, 26 Jun 2023 10:50:28 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBZV9W018138;
        Mon, 26 Jun 2023 17:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bzWJyfS333tNaqcwt38fMOKj1hJtN0eL68Zulq6Nb7E=;
 b=H+DPU0uMquDZjj9el9VCe+lpzeoHKHvANkzBdNo+34tqynF5SedRyXWWwSqfmd7E6Wwy
 XOHFLYDiVmft3ebgiRLqSnkT8fOstyKIqW1GyuVpHCBuLJz/wElN0BXxa1WlwBRFO4TO
 gVjusxphSPMds27WqWFRme3cp8FHFxhuY+EqHVWA5P07R9oFWCzkue5P6Ywbj1NSWYBs
 dEU5z3wAG1zp3hzcgQP5lAMv7Qte+JWBtdrYVpTJpk6+A7RLVrmhz+REw4kxQ1RDI+s1
 2ctW5evn97osdTofK5vmsZZ/+Mxi17R+QUY9Bp+K4RrgQvLbJ2KpQdaHHLD5JzZXgVIz Iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhckb8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:49:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QGUnb6033838;
        Mon, 26 Jun 2023 17:49:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx966qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 17:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYoF16Ju/jYsxGnGzB/hGS4APjU0WDhj0QKzrth4rFYa2rfAOdp4MFjevKPTq5hX7vXf31dJVmpcNjt8ZrjmgCruW/pGWtLli6V5DuJh/x5QPqHExeJsec+1RpGTgjWs3xVvSorFKv6pjKW/NiRjq0ve014rEuJiV6L83XVEZW48SKuD8ZbwG+05Ewt49VAqwKDLPQpYS7Vj12k/EhrCF2mNwSzcvl3LjGNmrUqZay4mnylPTZbLgfpzH6fSFfZcVTQ7XCLswpn+a0z1ivYuyo/9XTyPnj5vvPDLm1Iy+8Ac5TQO7MMQzv37m9tf0vcSZn0WaRpJqw0VAURGNS6LWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzWJyfS333tNaqcwt38fMOKj1hJtN0eL68Zulq6Nb7E=;
 b=d46vuBZR/D4ENOZEMsBVYhfza5k4sKn7XEZg6Zb720H66TwYYNdT+4RlDbgwoMP5yuovQx1FKqlS/E3wvEgVE7fCjDT/eOlBq9/BKoUSIWyVoKpLpWzot3hVz7JSE2pkI4utaPQ2IktOAPFWXa2M+bosvmaVYSyfv3unBRiXRQPTBgWoRJ7ZQ5rJLTEzv3RPiQqD3SPCaJ6TIcmcY1g9Q2Tzm4bv7FUnedF0bJsRer+iqf3x/+MR6Q24sbj2GE/CfWaqbB/aKCHnqBwEyOODVktUt2oRyHfGgcTfya2iNRmsV/PuJrneB2A70wGymZA//R2/ukkvcNJQb6h8jt2OBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzWJyfS333tNaqcwt38fMOKj1hJtN0eL68Zulq6Nb7E=;
 b=gxtQcZwG010O7/+kbpRpP8DTVi8QmmjIGQQoDe2Phdz4RmH6RWkguwAo+eWGZNcNZNgovewWts0QTLQKiclTnfEtPMjAvW6ydAlWI8UqzxX1xxQRz7FHCg58hMbxEe9dhJU8bkC8o+/V+tnK0Elh+Aa+AOLFv064QM2P/Aqo0Mc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 17:49:39 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829%7]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 17:49:39 +0000
Message-ID: <18ca0017-821b-595c-0d5a-25adb04196c1@oracle.com>
Date:   Mon, 26 Jun 2023 10:49:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20230615181325.1327259-1-jane.chu@oracle.com>
 <b57afc45-6bf8-3849-856f-2873e60fcf97@web.de>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <b57afc45-6bf8-3849-856f-2873e60fcf97@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e0babd-6d3e-483d-a7eb-08db766db6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g60ra83DlM+w0qIBe/unxb8CFur5Jmf0ZW3Or3uWCytX4SC4zPpQfID9Obne8ojCtaMZcGAOBrWyYc1pVyQJ+ZBJ4hfAftAK4AIGNjalhQcCui4jVr9ZJGKs5yh6ppcn6dnxY+wd3VBu8l5Jfo1xxbxGQQ7gPK6RTba5F9zPWPoC7bPYS0+sVsn2PSQdidXKdckwKfDjobgZBITLY6LJHepPnW35do25/N6Poe7ZMTtRO0V775lurwOFN9tPFaTulo9qKzqrwwbsUMj06ogrknp/ZFnl6tB6k12nYVOu5h3avXl4Xs82Psp/xC8peAlLA4Rdspn8yYqvcFVJ4OFuPEjNPRCFTkO6scV6yPWn3RZfYCJAjCXIL5h5fp3hNC9v+iYn6nRWD3UVWUVPZc/6HJ068tMTo8Oyc1edNxFOzL48vp/lL5O+qXb/vmJjFASWYq2RGblNJV68P9b/gQAkLJyD9wCTXhyIHPuPLs1ROxS3LuKnKJEic54Wgy0Oc+3sbglyYoAjqDYx6h83RtTT4l8PfhQhSwbyCcSE/q/9pc2uq/X3haBnxGgoAFbBQIN5ncZMZ69VptbD42l0g+mt9d9b9qK6r8Q5Kf2fck4w4WH52a8oUt2SlYfrtTeLhzUmhRSezHHIU+GBl6s/YTq8MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(4744005)(6666004)(6486002)(53546011)(38100700002)(2616005)(6506007)(26005)(186003)(31696002)(41300700001)(86362001)(54906003)(478600001)(66556008)(66946007)(66476007)(4326008)(316002)(36756003)(6512007)(7416002)(5660300002)(31686004)(8676002)(8936002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFjT3ZtUzN0NEhDeVN3cWxkZ25hZDBMZXdQUlVqNnUzR3djWDZGekNsSEtV?=
 =?utf-8?B?ZmZDUkNuVGFrUmhkYm5pODZ5YUZjVnRtNG02Y0krOS83dHcreEJGMjFjOWVy?=
 =?utf-8?B?VkZkd1VYcjcvK2NkcDB0elhic1NqS0Jra1laSWtTVUJvNDZPcnBoOWZzWnBP?=
 =?utf-8?B?MDBaSFpkY3gwWE5IT1ZkZVo3Y2p3QlR5TXFoL1NnaGFtY3RVd1ZabDFucEtW?=
 =?utf-8?B?QkNvTHdyek9CVjEvMUVObUJiWVluMXRrTXlyNzQ5aFdBZnRnVFUwM1lFdERj?=
 =?utf-8?B?Y2M4dlp2NU1VdTRwZ2J4SmJ4UWFBMGRHQk01Tm5VNEMwRjV6RW5maGJTYklr?=
 =?utf-8?B?bXliMGNmUXZoLzNkYXJESy9yb1BEMGFPcURBRllkTlN3RzFHMjY3eU1ZVVhK?=
 =?utf-8?B?MjdjTDA0eW16YUlaVkFuV2loaGxJTm9WVlFJc1U3Zk83N2d2REFJS2dwSFVX?=
 =?utf-8?B?ZVRNc0JIL1Q5MTEvWFd1c2tTbzJaV0E0dnZSbHVQanUzNUJidWlZNXJ0L1Ra?=
 =?utf-8?B?L1dHYWdVWXo3aWlXSlBLQWN3aDFtTTFxWmxoTkY1MlVOMjZWWi8ybk5tMnhB?=
 =?utf-8?B?dlArbzR6VUxNTVJVYkpwSm5LUWRkN0JSbzBOU2V1L1MyZlhaaGRmZ2ExTHI2?=
 =?utf-8?B?b1k5UjFTZ2IrREU5RU5SQWljeVpOYk5qc1NmQkd1MVlIY09TYU9RY2htM3N1?=
 =?utf-8?B?T2NyUTRFbFVsczBzZEFOVkxqU09qU0pvTkgrcjMxWS9rdXA2UW94dEk5VXVa?=
 =?utf-8?B?RkZSQVRmYUtIL2tFSHZDQXN2NG9CK0FQS1NVbDd3S3p4am9TU2l0ZmFCNnNo?=
 =?utf-8?B?NHcvNW90cjE0RWpoN1VnKzJaVXh4elcybUNSZmdSRnBQdlNLbGY0UEFRR1Fv?=
 =?utf-8?B?N0UvZVYwV0lVbXF6K3F2ZWtHWkpaQUswSDdTZ1NRMkUra3Evc2N1WTVyRWRP?=
 =?utf-8?B?dUprN0dOWGZyeWlqc0E1QjRablFDd3V5eUg2K2VYb0l6RTVpS0pjbXhaK3Z6?=
 =?utf-8?B?MUx2QytIbjNhSWx0NUNybzcrKzVGQkRKcVBRWkdTQzZzeE8wVFYwSG9veitH?=
 =?utf-8?B?eXk2SHdlMHBZbnRnbFNuaTlwbmtuMXlvN3U4aG1KSWtTUmV4SVV6UFhOSHQ5?=
 =?utf-8?B?UFlEU3VKNHpKOEhQR29mWGpjenlmaUlSL2tnemcycHY4TDVOLzM0NFZaUG9O?=
 =?utf-8?B?SE51c2lmQS9zZ1hHK2pBK3VnVXloMmFrY0xKQWlYcW5FNG5LUTdMMjVuRSsx?=
 =?utf-8?B?NTg0T294QUw0U0l4KzdTY2pLRXNQWWFsSFdHQjNhcXF5NGMya0FrbndGZEsz?=
 =?utf-8?B?N1RjQytiS0gxZ3Zsc0RheS85UWtEdVJUK05QOEtDbFBpdmNrcWpaTG1OVnNM?=
 =?utf-8?B?c0FDdUw1eDVnYXp2WVZLS2dKd0dVZGxzRFNrSVluT21VREZnSlM4SFVYOFdh?=
 =?utf-8?B?TFl0b3g1RmxzU1pqYlZnK0N3RUxmQStWcFZDNTUxOGxOZDFOKzJ0QkYyQVJa?=
 =?utf-8?B?UDhoTGRsRVgyTStzK0wvemh5T2srQ3l4bms5MkJqaVJST1lTcHZneW9yUXdx?=
 =?utf-8?B?bnQ5RHo4UDJBUVlKQWVEY0JKMUZMU0c3bFBBL3Naa0lOK1VFTms4QmZYck1w?=
 =?utf-8?B?YlhTaTJSR1kwVFNnKzBCS1NWcEIrWHdYRUtRTmw2djVpdlZMcHQ2cnozOVVK?=
 =?utf-8?B?TkY0YU9vb0tScXVkRlhBZVkzZ3BocXh5YlZHQTBRYmR5YW5RT2lsWk04MTlo?=
 =?utf-8?B?Y0Uvb2pnNVppVWIzUGdyYkJLSDNWQ05UY3VpV3BJTUthWXlpRkVFRHNJVUVR?=
 =?utf-8?B?RGh4TWFwajlIdHRZT0UrdTgyTG1Cbm8zMFhmQUpjbzZENXRJVHBEcHBWajBw?=
 =?utf-8?B?VDYyNXQyTDRiYTIzN2sxTFlGSUZtOXFHVys4YnUrbGlIL2Y0bG9WS3loZU40?=
 =?utf-8?B?NGFIaHViNmxESkdRZzdZT3ZOR1JjUXFiV0lhZWVxWExwckVQNXF5OTZjSlRY?=
 =?utf-8?B?SWhTeHR2Z2RwbVlhRWVCKzVZcnpvMHFNb2xwMVdEUWFhbFhvSk9ocWxmQlY4?=
 =?utf-8?B?aDNtS2h3MHR4RFZkS1A1Ukh1TytDdjhKcXVSOXNzWEN2MGFiTEwwM2xXajVN?=
 =?utf-8?Q?TkjRz0J3Cz6FIKl62vtFMB9uS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R3YyQWM5RWFHU0R1eGJTdzdYcU83NCs2VFYya2NYUE8zVDl6UVJyRUI3eHRW?=
 =?utf-8?B?dTdlQkhKNE9hZC9NbGMrK2UrdlZkZGd5eS9EZ3pNMmtDSEMvTENjazBhN1U0?=
 =?utf-8?B?ajJyK21ZUkhHNG9IK3BFYXpWWnJYVTdWcFBLWFg5WmEzU3BRRVhQbDJ4NFlo?=
 =?utf-8?B?OG45Z0h3MVcyR09GUEZodnVCVWE2Wk9tNlV1QWM1Nm1BM0lvU3hwNm1keWhr?=
 =?utf-8?B?K3I1bzNka29mdFUwOUtUc3NlTXV5cFlCRi81UmdpTXEycWdmTms3MU5mWXVz?=
 =?utf-8?B?MlV2M1o0RWIwcnB4SC9kR2FvR3ZuZG9HaXRrUTFzb0dUMExFUVhLVUw3TEZw?=
 =?utf-8?B?cnVWWWdVZE5LVGtwUTU5TGhEYmU2UHJtaFN6UVJYUGtDRUtMeVdPVERaM25p?=
 =?utf-8?B?OHBPdUh5d05VQUN5dGN1OEYrSlNpL0VwZlBsYys2MExsV2p0SXBMRTJwWHJ3?=
 =?utf-8?B?blVGR21NRGsxdlRSVFFrRTJKYnA5Z3F2NkVYeTB0UWZLdW1QVVpldk5SSkpM?=
 =?utf-8?B?dTV2NitXbHJ4SUVPemRuYmI2bU9IdkFWM3VROERIUHJSbGREREYrT1NKK3ph?=
 =?utf-8?B?Y21hTThrbkdEcnRQZmtQZ1ZqZVpINklLL1A0LzhoeWdYNmd5REJCRXZNK2wx?=
 =?utf-8?B?elpDd1RPaWZpV3lURkgydWVUWXNGL0JaTXhhU2FDOUpBMU15YVpvY2NySlRQ?=
 =?utf-8?B?SmMvQkRyQklreXIrSStndG04cmVNbmtycm1TbzRxUy9XeUJ0dm9uQVhQeW9N?=
 =?utf-8?B?MzcyTHRBVUNrYnh0ODliMHpWd0lRbGFiQ1hkUWRUd2h4ajBxRThaa3pLUEhT?=
 =?utf-8?B?V3ZTOThEaloycC9BWjRMK0RicWZCbW4zQ2UzaXBTUGpsbzZ1a3Jid2FUMjd6?=
 =?utf-8?B?VmNIT0tWY3A1L3pac0Rxck56QXlONUJQNUdHS1FRTkFzRWVSY3lnREtNRmJP?=
 =?utf-8?B?VlQwVExwa1UybjB3Q3ZNL2NmUTFlYTR1aEl2dFBrZEJna0pwak9veTJ6TjFp?=
 =?utf-8?B?djBsQ1hrOUxvaHcxM0lsNGFqcHEvcTYzZjJjc3ArSysvcWdBWkU4aTVTSjAv?=
 =?utf-8?B?UkhtcVZXWnIvL09pbHNSOHEyZEcrRnBlOHRjVi9hZVNNMzdKTWYzUGs4OFpr?=
 =?utf-8?B?NDh5RnlBcTNGUHpNTmFXUUhNTDBzS083bkloc0VhTTBFcEgwMHNMcmdTL0Fv?=
 =?utf-8?B?MkZoc2dOVFdjbmFUZ3ByL3d0aU5iK0N1cXY3a09FbzJLWjBCdGUrVUtNV04v?=
 =?utf-8?B?Mlc3M3RWSUlLaUs0V3JqN2RkcjBLdDgzWjVmcGRHRVJxMGd1Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e0babd-6d3e-483d-a7eb-08db766db6c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:49:39.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpJrllIVkXCcHP8wyh1nU67RMi6WrU0OFX+kwnhBUOEg4TFox4xkQxrPvXQ5/vEhvOdc3pPvjrWbzh9b8KaSVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_15,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=927 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260163
X-Proofpoint-GUID: 2pglwR1sAoJ0zWAKqRMQjDahqc95CP2H
X-Proofpoint-ORIG-GUID: 2pglwR1sAoJ0zWAKqRMQjDahqc95CP2H
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/2023 11:25 PM, Markus Elfring wrote:
>> Change from v4:
> …
> 
> I suggest to omit the cover letter for a single patch.
> 
> Will any patch series evolve for your proposed changes?
> 

No. The thought was to put descriptions unsuitable for commit header in 
the cover letter.

thanks,
jane

> Regards,
> Markus
