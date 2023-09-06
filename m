Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436D793F04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjIFOgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjIFOgz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:36:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BE10C8;
        Wed,  6 Sep 2023 07:36:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386EAncI010395;
        Wed, 6 Sep 2023 14:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=47yp/2PFmwfSJxRoh3qVhxk9VEpI7VNU0EZIstuwEHI=;
 b=r6/GUGqgzyCFMNTH5XCuzJ1vze/DuUIbrpsMlQ178sg2sWLqMfwiGcoAUPiKA4W7bjhh
 blM/ly43e9foweRg1CrJW4MILg+YnBwa79XYMRG3h/Lo15SaKgmSS7f5fyGc7NgiE+Le
 7Jo6Ghfr7RMNiw1jL5WjScWpGM9kEJVkbn/tOiGfZbeITHjsWQHDB4mBug3+3mwjvgj2
 4TIYeeWYEEMFNz6l6Is3I3AY8Ykh98Gt8gc4/OV2Xe+I7PaxOSxWbkd2IyzJXD1pvVIB
 Z064NmKmnp4s4SzawdLt0HEuNaNkpDLSvJROeDVzUf8pGlTdVdNpGhhf6rt3q0AOKF9A 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxtxwg2aq-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 14:36:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386DESeE029064;
        Wed, 6 Sep 2023 14:20:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug69p6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 14:20:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3B4e6U89mj2a+R5PBxr/jEXkq2xB+Br9kK6brJcH+nt4cpiSv0sQGseg7TgWU5UCEjs6SzQX7IfgJEFs8tCCEwML6v9cTN7y+gdi6jwL1JEi0AURuTlLCNFkiOCRV1++1H9uZF3WX2iuyN8mvYEkSFKrvVowLbBL9gP5a0YmnkB9DqFhGtQMLqxCaPQxso+CRc3dA+BMDDnu6OvKID6rGbBV8RBK9cXjdAkNoGQgJDo2yum2fkDjwimQp4jwTb/qPv6+AprMjbEmfzKTTLz0ySI0U37CAYzNA0URVaoJL74qvTrXOa9rRDRcMgt8QFlmQxFMIzRFdz1AQD7n2Rw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47yp/2PFmwfSJxRoh3qVhxk9VEpI7VNU0EZIstuwEHI=;
 b=SLW3i7R0hSse3abL08agVdDHwffJYwLlC020GRunz7Sa72cpNA/9zlP+mHmm89+VQJewmfceArs1/PzNYJPyzP4M2SzGz6fyjPETZl11Yi+r56uDDtnZzqB2VQmR/oq8LJYEA3LC7+vFo7fRDqfaG7t4ssbRC+Ei7sGQt7BxXZzg1qctu7k2cy/vNez6qHDzVIHNq9+RMzou6fjWbu3GOzaXhNHPwHH6q7j0yzmarjxTW22ooJLhODB82wXS1OJhc8rJ9B493LbDp1JLWqq7ijOq7HAv2cjwz21xitJ6coQYHjE8frR2ioMfQAEj9U0x+YNj3OBqx8NAZBOoBBI9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47yp/2PFmwfSJxRoh3qVhxk9VEpI7VNU0EZIstuwEHI=;
 b=nga4touYgYh3nyMqg6lkoax77iuTzboVesFL+JOK4MLPNoEuJPk0mJLhRSbkTzKGM0b6Mfgs1lCu7W/WXq0nJ1IswE4aXaaoL+uFuYhnvgMIZY/+c1vKn8GdNF6WOX8Zk+bFHDDEcL1uH0UULq9RQq6I7KC6HK6I8bQo512UpXk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 14:20:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:20:04 +0000
Message-ID: <bbb42413-7d63-c9af-fb78-e00f491812dd@oracle.com>
Date:   Wed, 6 Sep 2023 22:19:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH V3 0/2] Supporting same fsid mounting through the
 single-dev compat_ro feature
To:     dsterba@suse.cz, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com,
        linux-btrfs@vger.kernel.org
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <fee2dcd5-065d-1e60-5871-4a606405a683@oracle.com>
 <80140c50-1fbe-1631-1473-087a13fd034f@igalia.com>
 <20230905164359.GE14420@twin.jikos.cz>
Content-Language: en-US
In-Reply-To: <20230905164359.GE14420@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddf028a-b866-4f63-2c33-08dbaee45d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi/tkLLTFht5FJ7daGR+z9wqEGdJz6/cCBvJBOahGCkb0fQXM4f7QC37As2kCBl1atD9pwm3agLkdgqMHcFuvkGGea3CdKv7pWKb1cGBv3qdqmIbs2cGK5NUb3KAl1OJYduWOUwjpLo3mwBNF4w4AcUo6T5BIF4LMCE3xiiSoD4MQIcS4OOhnfd1Xnv61WQY8ctL3oQDZXerf6ssiLXvjewRSkkWeKdSzR6iJ2IenpWJzHY7GwBBlO0bVNh9KSwwil8YLi2kdXSLk83HPd6ThnFv3UYG1mU2bXMMJYpvnMrwV3D90nXgwcVpFW9jhNR5F8Nyz/iZ6zYyXYTNAa6b69ZKFWQ4myCYcWEHRtkakCQEPlHipoU39mXDdIefzsKTUx6//2zmH1x4AX8LFGZr+ZqntHiFVYE4qq6ep6Y4YGfPKYJDOrHR+fPU+7MLMCmY+v4kZbaert8pKrzgpz33GN5cfWV8iPYiS+g0dgOH6a22cEkEGP0RPSTj9XIoNmfbNgLSU7kkf5aTM05/hlpdhp0HJRICnQa3jyAKhuogqynwpJOwfdvteYgK51BpoydaHjCFDQrD2a6LBvTxCwMW0mBU9SS8Lt8GJIzI2+QAAf/je1c+vWqri5f2RhEYm8YYOtGjwnT+uwBRxZXrH6vGWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(186009)(1800799009)(6666004)(53546011)(66476007)(66946007)(66556008)(6916009)(6506007)(6486002)(316002)(41300700001)(6512007)(478600001)(44832011)(31686004)(4326008)(8676002)(2616005)(26005)(5660300002)(36756003)(38100700002)(2906002)(7416002)(8936002)(83380400001)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNnYTB3VzM2ZzlZWUFoUE91SlhkeVgrbWl3L0haQytwM0dJMFVDM1RpbDRR?=
 =?utf-8?B?dHQ2UDgxbU0wKzZqNGJNV2VtemFWeFQwaUorOVlYTTd6NTJQai9RQ1E0eGN4?=
 =?utf-8?B?cU1seTF0NUc2Q0FYOEgwZ3lTcVVmUENRM2daRHozWjBYQ1ltdGJ5OEZRSEtU?=
 =?utf-8?B?WTdOdUxmMzFQTi9jejlqY0l1VVRiUXZRNnJoMGs0SU5VRCsyQjVjL2NNVFZw?=
 =?utf-8?B?eWY5OEpQZERGOTVScFBhZTVQS3pyaGZYNmNieGFJNjJKM3dTNlh6d0dsY1Jw?=
 =?utf-8?B?K2hwbml1WUtYY0E1MEk5Z2Y1MDBPWkVHeW51di9GVHUwaHlod29taEp5ZTI2?=
 =?utf-8?B?QTZOVXZrY2krc2t1ZEYwNnY0R3B6cWJSYTVaYzFDd25TTHFNbGYrNzBXYVB6?=
 =?utf-8?B?WTRGa2d0TVVzZDNtTjVsdTdOQXVMN3NudzlqSGJzdERhSVgybkxsNlFyUU1o?=
 =?utf-8?B?WXdVUk42SEk2RXFLQm5yeFVMSFBWeE1LRmlOKzQxZ1FIUldrZzlFQ2tGM0Yz?=
 =?utf-8?B?Vkh3a1FrZVYvbXFicEd2cUhGUjJPYis0Q3FPdWVTa2RxQmhvUTNGMFJvTlI5?=
 =?utf-8?B?RGVkMWREaitwcGNoalhJR21Jd2xsLzFlNmhJK1drUHc2OEdtdjJjTE5KeG5Z?=
 =?utf-8?B?NmZsak12RkQ2WkVDek52eTRLcGJOdVJ2MXpZQUxNTksrRHFaaEF0Sjh1T2Ja?=
 =?utf-8?B?S1M4Qk1yQ2NlKzdhYUpLYzZjNmhPSjhkK3lJV3UwdEVBZWhlbUJELzQ0eUhE?=
 =?utf-8?B?QWd6a09ERDVIZVZPc09COU56TzYvU1htRjBNanVNWWYyZnNPMG1QN0dsR3kz?=
 =?utf-8?B?MmZjeXBMdnhMQm52aUw3ekNwZHFYWUtnZ1dFYi9rdzUyZC9SLzFaalUzaEFW?=
 =?utf-8?B?cWMxeGhnYWcvNWJabWhVTWZFUmU2UXQ0cHlWMytjdmVicGlvOHhid2RveWxv?=
 =?utf-8?B?NHZoZFJ4WmFvcnhQQVAwTGdUZTg3aWE0dHhYVzU3TGMyT09SVUVnUEQramRR?=
 =?utf-8?B?UGRhTGxlMkoybTFvWDBVRitCOXJMc1JnWVhJSDZLZ3RrY1FSV01CaGRIVWZt?=
 =?utf-8?B?QW9qQjZFOGd1dks4dDlLekUwQm1aVm1LNkFLOHpIRW8wMmJSY2E0T3dZQnl3?=
 =?utf-8?B?Z21KdExONDdxMVJEM24ySmRJNktLLzFFTmRpSXdmVVZjd28rUXVPMVhjcDlq?=
 =?utf-8?B?Ymc4NGtaTHhNVmZYM1UrdEYwZEVpUXBIVkY3OGxlQXN6ejhOMlNKdnNxU2hK?=
 =?utf-8?B?d1kyemZhd2twK0F1R1dZMEYwR3F1MXNrWDNBaGsyT0EzUldTc1B2RFJBU2Rq?=
 =?utf-8?B?TnZna2tKODhGSUhDREdrQmVsNkZLbk4wTVBsRVpvR09OV256akl4L2Q5MWxn?=
 =?utf-8?B?T1cvWEc2SHpNRzNmWlZoT25HR0liNVRGUUJJOE9hWVNHUWgzaWpSQXFEUzl3?=
 =?utf-8?B?Q04zSmlWMEt6RmUrbHlOOWhKSEN5bHBGbXpDQ0lMR3ROaDdBaXJqQ2kyNW1N?=
 =?utf-8?B?TlkvQmZLTHEzUmp5QXpJNWN1bHZ5S3RFRllRWVNGQjRCWjFQeG1xSXhZcUhD?=
 =?utf-8?B?OXozWStlcDdPeGpaRTBDSG9lU3Z1UEpuc2VyY2txb3lvNWNNTTVobmo2elNs?=
 =?utf-8?B?L3lKdUxsUEs0Rmg0NGdDb0puWTVmZ2c4UEt3cEd0Q1Y0b3JFOHQ5Mm9JbGRj?=
 =?utf-8?B?bWFOTGlLRFVJQnJHT1E3NHpuM1d6UU9Xa3JtWmViL21Ud1lLVjlrUGRKSHhM?=
 =?utf-8?B?SmhrVlY3VWhpbVY1bkZnSmJyUDd3Y05WaFcydk1ZbGZvbDdOeUgwN2JnMVVI?=
 =?utf-8?B?T1hjL1FZaGVTWUZ0alFLUU9hZ2R2bFRKUVQ2TU1QcFNEejNSNVc1M3JkUTRx?=
 =?utf-8?B?aW5nSi9BMXdzRzhISnhqZXBZbkRHT011UW9aTzhiUDRvQ1lJTUdUK1dpLzV1?=
 =?utf-8?B?S0NQUVZFNWhMY2h5cjBwQnFpWjRhV1pYMGEvQkM2aUpwbjdmdUVPUk93NFAv?=
 =?utf-8?B?U0ROdDJUK0g4T0daVmRTYWZ6Rk54T2lLNm8wckxSNU5jSExpa284eFkyaFp4?=
 =?utf-8?B?UTRNUzlZK2dBRWpDSGdzR3FlU2JPZU0vMHNtemJKMHVRTUZNem5pcm9YcFBL?=
 =?utf-8?B?TWFYK3hBQmM1RXVMTm01NHJVZ3R4R0NuMGVWWno4SDVXNk90dWViRHBjNGxa?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V0ZyRlZTTHFpWnFLaCt4R0RUWVlGTWFEY21UQS9VR2ZpbUlxek01NjBxbE5y?=
 =?utf-8?B?TnBEczQ4OTZvNjUzNWVidGdxZjIwMHUwdWlQeXRlSGE3OXVwdVh2RjhqQWNq?=
 =?utf-8?B?L0ZzclhuYXByRVRWL0QybTlmRXhWUGxjT2dGSVQzQ1FlRUNjMEt6eWkzN0pO?=
 =?utf-8?B?ZW82VkF5Y2hiU1oxMzQ1QUMxK3hBaEYyNnArU2ZCMVVRZksvS0dHd1RVM3R6?=
 =?utf-8?B?bkp3U1h4MmkveHBUWmlQbkgzNk55MCtMUVdwMnFUMXUvb09YRmV6SWlXd2Zw?=
 =?utf-8?B?WlNIcENROGM2YURoTXdzNithYTN0dDNxZkYzZVh4Ympla0pFclFDOUZETzJF?=
 =?utf-8?B?RkxiVVI0ZDM0S3RPbnBVVmRCekxQUVZ3UUJDNEUwTmVudEVqQVpKb3FrMlA3?=
 =?utf-8?B?YVlpWlJiUXA3Zy9mWWVaUXlhR1hDQVF3YVdiSTNyK2hDSWE3Tzl2UlVxeDFU?=
 =?utf-8?B?QURSaERNU3RKWHBHUXJ3bWcreUxLcHdoRk8rVThielh2OWNmRmd4S2ZuWGJq?=
 =?utf-8?B?WDc2M1lITmFPNElGMkYwSm8vMnBDc1ZiZzNLdWZxa25oWVRpaEd2dnBYemVR?=
 =?utf-8?B?MDloYktwWmo5dWUzQWRwVXRjcStqaXhWN2wxcWdQc1VjYm9vWHpLdllDU3U2?=
 =?utf-8?B?MCtCU2oxVUJCc3RFVWZ4YTdTUWE1NndYbWh2bmVRYTdhZkJ3cjJET1hWaTd5?=
 =?utf-8?B?NDdkQXFBU2NYbjg4dll6c2RkQUg5Y2NYSm44ZW51NGp2MDV2S2JkekppUFJo?=
 =?utf-8?B?RXdjaDNuR2lRTzhuMS9sZnZ2ekk3K3FaYW5aLzRzbHRCQUpDNlNhemRGMjNV?=
 =?utf-8?B?ci8zeE5SWnBHdjEwcG5OcStLdVd4UG5GNTF6VHpUUHkyZ2s5cEE4MVJ0bGRx?=
 =?utf-8?B?SHdRdm5QeVNLb2JyUERVaWdtWDY0eldYWTZ0ekk5VHNvSWptTEpVK1R6RDNB?=
 =?utf-8?B?Vjg4cFovY2VDNExRRlRJbXRvb3dsMWNqK3QxVTNVa1dVWUNHMXBXSy9CdWJV?=
 =?utf-8?B?ZlBHTUNxR0V2M0ZFbU03K0kvUk1YbXBDbW1DWVM5NUNmT1pKbXBFcGtBbHdp?=
 =?utf-8?B?RktzYkFkZno1eDhTY2Z0ZVFBMmRYN2xCK056d2pCVURudng4TzExaFJPN1Zk?=
 =?utf-8?B?ampjN1NWT1d5RDRNVUZ4ZjJKV3hrMmFXME5laUtlb2N2Z1RwNzN2NU1ERnR3?=
 =?utf-8?B?c2JwUmlkOEcydW55c0lHUythNm1ucGFUSlhvU3ZDQ2dHalZHRFU0dHBlYjM5?=
 =?utf-8?B?NVhHcHdJc2w4R2lzLzIzQ0Nxb3cyVmp6YTlIWGhxRFAwZHBCdEYrV0ZoNHJO?=
 =?utf-8?B?NTNEcHN3ZzQ1R1BZUkN5OFYwc3JIRWRyRjNaSDdiTTBpdUM2amxGRmRmZm9Y?=
 =?utf-8?B?eVRwU1hVRU9HeFJzaEY0NEhuYk54UjVuWWVzeGM4T2VPT3hZaW50S1lkUW9K?=
 =?utf-8?B?cXR2OGlzQituQTdpVW1iYnhoKzM2V3NYdHBpckZBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddf028a-b866-4f63-2c33-08dbaee45d0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:20:04.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/waPCP/zkPZ90wkuhKGzsJgLNKAvcNZkjoILJYrFCMuwKEbCqeVkexbZM0KV+vRmj1bCqnH/QKmFv73Jdcrag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=897 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060124
X-Proofpoint-GUID: lrH0rnxY7HiVslZwE1uJw8MXx2q-wg15
X-Proofpoint-ORIG-GUID: lrH0rnxY7HiVslZwE1uJw8MXx2q-wg15
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 00:43, David Sterba wrote:
> On Mon, Sep 04, 2023 at 10:29:52PM -0300, Guilherme G. Piccoli wrote:
>> On 04/09/2023 03:36, Anand Jain wrote:
>>> [...]
>>> We need some manual tests as well to understand how this feature
>>> will behave in a multi-pathed device, especially in SAN and iSCSI
>>> environments.
> 
> I don't know how good the multipath support is on btrfs, it's kind of a
> specific use case, requires a specialized hardware and emulation in VM
> requires iSCSI hacks which is tedious to setup on itself. So I do not
> insist on supporting the single-dev from the beginning, we usually
> start with a more restricted version and then extend the support
> eventually.


Although setting up a SAN may not be as swift as launching a guest VM 
using a file-based disk image, however hosts running these VM guests 
rely on SAN-based multipath. Yep. Later verification is fine.


>>> I have noticed that Ubuntu has two different device
>>> paths for the root device during boot. It should be validated
>>> as the root file system using some popular OS distributions.
>>
>> Hi Anand, thanks for you suggestions! I just tried on Ubuntu 22.04.3 and
>> it worked flawlessly. After manually enabling the single-dev feature
>> through btrfstune, when booted into the distro kernel (6.2.x) it mounts
>> as RO (as expected, since this is a compat_ro feature). When switched to
>> a supporting kernel (6.5 + this patch), it mounts normally -
>> udev/systemd are capable of identifying the underlying device based on
>> UUID, and it mounts as SINGLE_DEV.

Great! Thanks for confirming.

> 
> We at least should know how some feature/hardware combinations behave
> and add protections against using them together if there are known
> problems.


> In the case of multipath I'd like to see somebody tests it but
> as said above for the initial implementation it does not need to support
> it.

I'm trying to set up multipath, but I haven't had any luck so far.

Thanks. Anand

