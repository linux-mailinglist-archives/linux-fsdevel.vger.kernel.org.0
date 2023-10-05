Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135B7BA5A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbjJEQSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241350AbjJEQQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF044BC;
        Thu,  5 Oct 2023 08:11:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395CUouW026796;
        Thu, 5 Oct 2023 15:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b2wd05N4GEz1qsVbX3L7vZtQSse/CZ2Q+/FtsUOtcf4=;
 b=uu+0bQpZIH+W4i3WwzPjQrKDm3/uPb8MPoIdUh6qK/0JSW/+N9M/EZQpsR9QqydNANGj
 8jeoNarjusX82Sionab3etIvc+zYE2LLWgB0nlbYzFy1umiJg/ysvdDevVMTRtGpNa6f
 bbgMYTztTibZq+eadqcPyZcujvrVGuU5aT+GD0lP1IDJquOv5TbW7pzhkc9FAxRcKR8s
 VB5QJwkt/cxqBI5PTqF0qo3oHSQZK6OjYh3dCiFKfn8y9wgVSeF6BnTkI5w/piD3MfuM
 grzHXBRRi5XN7zU0owCe5t5YfjsAVx317GiF4TWIzswkTJH84gx+8f2dsKm2iMLNO1GL Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ehrv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 15:06:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395DwURo008859;
        Thu, 5 Oct 2023 15:05:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49qt9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 15:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKM4qk/TMZTWf6avidZ0nqL9yrW8NAxhlqumPrGY/8kzPWbFEzgEB/Yms2FfTwStmCVhgyHS1VDwNgSvW3FrOHvHlE8sqceTA+hSdfr0/aBc3qvKoHycGlD2d0X9EPedEYNbOdBwr5xGpvFmyymkPOi60iFb11L1+olWCK5rfll/XaMrpzLCPowcnDjzgTQh8w/PDf/Low9fjfwoK00prFL0hS8lDMabOZ9yGr+2Egmg6WMqHy+mP9mYLBcqX1oDkuJL6JmE2ZMmIm44l5HI6mGe5Bdm//Ygy69GNzEo9mHV3WAx1a3wraabK+KbnzxtMfhEG/zJX3XM3X4+BHrbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2wd05N4GEz1qsVbX3L7vZtQSse/CZ2Q+/FtsUOtcf4=;
 b=e05FMjSDWKELDM6VjrZRa/IeQZ8nXs0sP5XN4kz40c5B+fwEe3ChQafvH9o6tnp/4KjD0BMkCnV2GoLsBNsTkclYMN8r8tkVTkGFfynKZKYt7Y+ruZVBUUHkasYCzZDR0nI42OKJOS+lUSm10mnpIwa8Q9y0IdIJ5XOiEUzUAcqywA4kSC5wYcl552FPOrd9Ajz4ZpicEZCTEgsmQvMHMfAhcK/zM8yybLjN37iy0VyhrL76ovjMpoR74SYC5fsAHhE9ff0z1aF+oiURM2SZtXpr7xKxUXicKHBOe7eRFqicjiUkuIMHwAEl9lS+K+SLfIr5F1VLHjkPWCyvQU63sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2wd05N4GEz1qsVbX3L7vZtQSse/CZ2Q+/FtsUOtcf4=;
 b=VO3Uix0ayj06ffj/OS/moYo0b8N729U7NqSFeJv+cxhTnPDElZpszRgt+hiA6kUkdjIz7i5y3C0Z+QWm3se2AhzgnX/L8RV5ipfBwVoBQANqWJ+WAAB9e64Bf/Qlq9IH6ao7yMpNi8K98eeoGvVPrzliQIwJ6kHGEZTDv+XLFeE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 15:05:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:05:56 +0000
Message-ID: <008b8ad7-d6c0-e026-9e12-1a4d92848c4c@oracle.com>
Date:   Thu, 5 Oct 2023 16:05:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Alan Adamson <alan.adamson@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-22-john.g.garry@oracle.com>
 <CGME20231004113943eucas1p23a51ce5ef06c36459f826101bb7b85fc@eucas1p2.samsung.com>
 <20231004113941.zx3jlgnt23vs453r@localhost>
 <b6ed0e26-e3d4-40c1-b95d-11c5b3b71077@oracle.com>
 <83f58662-d737-44b0-9899-c0519a75968a@samsung.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <83f58662-d737-44b0-9899-c0519a75968a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:208::35)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: b44a0138-2bad-4d18-6bcb-08dbc5b49363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vX2SSBcx0dIrpwyms3NwG68PK8VN12P7W4drF1VXtKt04F4L96Z16+RAdcdmK393n9BkbQiPpGZPePSHkiuv3bamiZWYYWAwer9Bq9G48KSDp8MilBe11Nrlmp+GL2b89NESG0xhi75SuENkqOxmlxhFEaoUidVDqAb9GDja4e0n2ifYb1mZPbNo+0WT9WkTIltsWq8aGdlZLQ/D2KHDAaFKWSu4Y//RRqcGVz+DTtCXND1v5vJ3eCLayMWjIFCp9LaVxRhRsgBm5D47PLK5qW0OxhlLc2QpwG2474sHRirnVf8p0OJ3qqYRRLMH8zKuEx0lXG+ZATHUry/4UQs/oT5XsXKsGGCdd7oMtkajpqBRWU6hCX+9QZFla7+/K74hcxpNodT1gXuyv1YznUhzZqiJ2zMRTMFI2ynY3ZWex0+Iw6rqwCuAgXnQM77Dfpnuee2Fu1zx5Sn550/w8AVs9eA5uQfNCjYwwsMwPLkgNHigLbVEDK9bI25l/vW5soKFeWl83E/cy18xhgomGkYN1KZn5qyITLafYDI4EjA1weXf5sj20MEyuaH5O8JoGj9p462NjvrYtEIKomrcok9TMRgbKLDuIPdQIUMPuVm+axMQyFc4JkssoONzajM+0IDB9PShOWg0k8IihSuwZhjdqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(8936002)(7416002)(31686004)(2906002)(5660300002)(26005)(2616005)(8676002)(41300700001)(66476007)(66946007)(66556008)(6636002)(316002)(36756003)(4326008)(110136005)(6486002)(6666004)(83380400001)(53546011)(6506007)(36916002)(478600001)(38100700002)(31696002)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzhDQjdqMmplSjNvdzV2OERsSm5NM0RUZEtWVUZmWmFndFdxbnJRckl1TUVj?=
 =?utf-8?B?NCtxYk1VbGVNSzVadkw3TVlaWW0xZjhCQkxXQ3V0eG04VFlVeVQxZG12Nmt0?=
 =?utf-8?B?bnNDVEdNSzVKNW4wU1REeHJPRzYzbHdqZnpkZFBsY1NVNEppMU1YdWVKZkJQ?=
 =?utf-8?B?blBKZkFWMXlCU0dPMFQybFcyTzE1TjBJelRUL2MwcXhnSkNPcDk2NG5MU25Z?=
 =?utf-8?B?akpTbTN1dUhYMi9RKzFQbkluUENMcjdFVHl3ZkkwMVdjS1VtRXZSWk82aEFS?=
 =?utf-8?B?aUFGWXpqT1d1YlBmT0Q2TDFpcW0yYlpkOGlQWkNkN0l4eU5GUENySVFZSFJ3?=
 =?utf-8?B?UllqU3BqSUFYekx0aWlQTmVNK3JLVWNLN09uMHRlWVYvMXFjT3Q4NlY4SG5l?=
 =?utf-8?B?VXBrM0Z1RWJXajlRM2s2UlJ2bmh3RDlTQXdCTjFsNStnOWRGYnZ6QW02ZlhV?=
 =?utf-8?B?azAySWYwTUszdXYrdHNDV0JhdmFTQlFmZzd2aDREV0FqWHRpMkpzM1lNODNQ?=
 =?utf-8?B?OUVUeXVxNFNTVExSR2QvaDRTRDQ4eEFINE9La0VySHdrUlVwMGhSWjYvQ20y?=
 =?utf-8?B?VVY0YllqQ3Q2Y2I0R1EwLzEyRnlzT242Q082UU5kcTBCRUVZdmdaZEJ5WEJo?=
 =?utf-8?B?aEJKWTZhK3hIWXQycCtSdlBQSXNwVXhxS0xsbytKTEV6RzZaYkVGU0NZejFN?=
 =?utf-8?B?WXR3YVI1ei9hL255QlhLZDdLQ0JGemhmS1FuTTgzcmZXK3Uwc1NESG9EZUxM?=
 =?utf-8?B?MnN3b2dQS2dLYk9vR1M4cTB6Q1ZwdXF3c0RReldpVkZuVjlwQnk3cXBEZjJK?=
 =?utf-8?B?elY2TFlMMG4rMFZjK2lVRFR5LzlYeW9OMmlpRGZTUHZ5eGpHcko4ZEdhdzRS?=
 =?utf-8?B?VXVvRWlkVWZMUzZEYWFaUXp5ejRsZklMNG1MT3NzT0JPU3Qybi9KNXIvYWE3?=
 =?utf-8?B?bGJtWFRMc0YzVStJZGxlOXVubWFnQ3NrVnNISlZWd2pWakZ1MWZBbXB6T2NU?=
 =?utf-8?B?SHZoZUhtYVhibnNBV1dsRGQ5aTArZUc5VGRhK1JYdWIwRnU2eTlvd3BlL2pV?=
 =?utf-8?B?VzhkbWNVRUZIOGQ4ZFQ0Z0plWGRpb1hTZmErOWEvUHY5R0IwS0luRmNVNlAr?=
 =?utf-8?B?VlNvOVBFYlJsbHoxV2E3UTNZUGNYb2x2RTk0Z1Q0SEdxbWt6ZERNaDdYbkw5?=
 =?utf-8?B?cFpMSFkwN3NxOEpRbXNWR1FYOWI3ZEhUOCthMHNONzF1aEhrOXF5blFQLzVq?=
 =?utf-8?B?NnZHenJ4NjdKUWpRNHl1L2pmUVBKVm9USjkvbk9nWTkwSmRDUDl4Y25XY3M5?=
 =?utf-8?B?TVc3Ty9QYVd5SXprYk9HVFQxTm1QYnpidklkZzRBL1c4TnpiR21ZRUw3ejls?=
 =?utf-8?B?MUtnZWhDTllkNW1telRsbVV3am9Ibk9CZ0tYazB6ZGU3NHVSTitRdlpJZHRZ?=
 =?utf-8?B?VkpCQTF0L1ZUNjAwV1FqSkthb2pSWGNGWTBjSUZwTWQ4M0toMkE3blhVSVR4?=
 =?utf-8?B?aU16K2ZPSHAvendXMDdTTXY1K2NTN28wUjRDYTNnNG5qa28vSFlxMkNsN2lx?=
 =?utf-8?B?dDlnSzlmSUhEOXljK09HTldUQ2hKT2xvMS9QcmFRbTNTUC9PRWpYdXRYdzM3?=
 =?utf-8?B?UEV2NnNXTGxaVE5BNkhIZFV3akxHN1V3eVU1ZFJkVzFNR0ZERFVFbUxScW05?=
 =?utf-8?B?Si9IT0RhWVgzSENFWHdLY0FKM1NsbXgxeWtCSW9TNmxUdWFyM3hvbWRDL2tL?=
 =?utf-8?B?YnlOUmtSS0ZNY0doa0p4MmptOWZuQitGeXozb2VtNzRhell2ZTNlcnVEMVd5?=
 =?utf-8?B?TWdTdm83Y2ZJdExGdGdsR2hpTk1pYm1sMDN2M2U4SUFSRG1NL1hBR2xueGZR?=
 =?utf-8?B?eCtEWVkxTG1tcTdVZUUyY2xyeVpreXZ5QmlLVUxNMzhPYXVlN00xaStaVXZT?=
 =?utf-8?B?WFBUdmRnRll1MUNDY3NQcFNUVUpZaDliVkVrcFhhZitGdkRUT1Zpa2QzRGdl?=
 =?utf-8?B?RjBmandLY1ZQNkJJVVN1WE12SElLSWxmTnBIRXZ4eDFDeWJGNEpzRjVjZnJX?=
 =?utf-8?B?MkNUekphenduVktST1NHZm1zbHdqUmtmaVIxUGxHYWRPeEh2ZDNBQ3VhcVhH?=
 =?utf-8?Q?Oq4/4VudK3u5gKdU6i8kLKaLk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QndkYkFYMFU5WlhtemJlTkdsMVJxOWZiZjhTM2hiYkZHUms2RU5ucjdsWHlO?=
 =?utf-8?B?Uko1Y0FVRGczSmNIWEJwbWpBV2sxRDhxWWN4Mm9DQ3JXbHlwVHBVM0R3OEZU?=
 =?utf-8?B?L2VyQXJwcnFUSGV6OEd2MmpZT2ExUGVSVEh3aTJGYTdMZXo1TzJTbElQMjAw?=
 =?utf-8?B?TSs0Z1owSk84OEZtVDdWbi9sUXlkcHQ4ckJFMjd0RStKR3B2Y1VMcTR6ekhx?=
 =?utf-8?B?ZTVpaVZrZjhBNXhaQUJoZSt2ZGE5MXF5emtSNG9nYkZhYkVIZ3ZlZ0tXd1oy?=
 =?utf-8?B?NlVTMC9wYVhhaWRrakEzejlrZnZ4aW9CNnBHQjllTjZncFJuN3hBd05hYWpH?=
 =?utf-8?B?dTh0WkhXNHRDSTFFWElJR1RvZjVIeU5WOVZyUDNVdld5K2hjbVA5cTBTcUxQ?=
 =?utf-8?B?THNldEJhN1Yxd0YyeVhNamlJUVJxbmR0K2VXUEI1NUxpeEFUR0pUTWV2M1hL?=
 =?utf-8?B?QzZaaFZBaVhLZ1NETk03eFlUMzV5VVNZb1lua2NEclUwdDVIMHdkSkwwbkkz?=
 =?utf-8?B?cnpGTEdhTzBvd3lnRDU5Q1BlOVNhK3lGRmN5SWF4cjNiZCsydGNJMjlJVXJ6?=
 =?utf-8?B?ejVPdEtZZW1WUG5FKzRKUk9OOUxzRkQ5a05MNFp4eWt0d0dmN1lQTHZBYWht?=
 =?utf-8?B?NGZ3c3dnOGpxQ04wTUhKQVY5MVM3RUdzVzl0NTk1bEovczc2ckE2aHFadk1i?=
 =?utf-8?B?RCtQSnhaeU9NWTVJbTdIeWoyY0ZwblFyWmc4eUdUUlVjdzg1d1V2ZENEM1BM?=
 =?utf-8?B?QkpvbXlxc3h1OVpCRDROSXNHVVpMa0pzUG9ReUtYemgyQTJZNW12TmcvSVF5?=
 =?utf-8?B?Ym1nTHJNbXZkOTFrQUJCQXo0cTJKTDd3dkw5VFJVNTJ1TjFJTlZXYU1LUU1Q?=
 =?utf-8?B?bnBwQkVhTkFGcTJiY0pTcE5lNFova1BxZ2ZTU0w1Zk9lNFEya0N4eUp1Ry9a?=
 =?utf-8?B?bjltc2JmZDRxcFZ6bGtmRVN4U3pFa0x6amZ3V2lHbzRWcWpYd3JxMXhpMWdD?=
 =?utf-8?B?bzN1U0hWODJKc0I3SU0yMCtvY2NHMWx3REx4YUZrNXl5VGxXdmU5by83dmJz?=
 =?utf-8?B?SHVhVHJIMURINUFZTlFLcUxnSnpiWW1SakJSVjZKeG9WQ1ZISjhZL1lMREc4?=
 =?utf-8?B?dUVtdDJab2poSCtlVmdIb0NEOUQyN2tBWnhEQWhJSHBLQXkxYk81MlhtOHc5?=
 =?utf-8?B?T1lqSnFIOHpsMlJYVG5hTFVOdUYyRVE4Zk82NForWkthUUxVV0FESUowa3Jz?=
 =?utf-8?B?T3FjR2xCQitXc0VzcEdZUHN2enRpUFFVdS9ZUVcwUlJ1d0tJaVMzcCtRMVZX?=
 =?utf-8?B?Mlg2NDVLcUQvUDB5bjEyNlhCWE13cWtJalY5blNuRTRaWHkxamViSHhBZzl0?=
 =?utf-8?B?ZDJiYkEwcEJ6ZkJVY0FZRzVKazlOd1o0UlhmcUZCQlNESVNvanpxdHdid0xq?=
 =?utf-8?B?Mk12UWd1WWRQdy84N2RBUjBBRVErWm5EdzNROXh5TXVFTXFZM0dVZVk5VXZh?=
 =?utf-8?Q?eGkS6SuPeEMG1Y0IbUWRZaBI9iF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a0138-2bad-4d18-6bcb-08dbc5b49363
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 15:05:56.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsdArVLPRt+EXcY9hU03niAKI2i/JBQClTP7J/hQ/Q7qGKBurRkPsstm27ZPEPUGzztu9ojql9TxB/suvwe9Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_10,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050116
X-Proofpoint-ORIG-GUID: CLDLPex2-uCGcL4rIriYkgMIABaOILfj
X-Proofpoint-GUID: CLDLPex2-uCGcL4rIriYkgMIABaOILfj
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/10/2023 14:32, Pankaj Raghav wrote:
>>> te_unit_[min| max]_sectors expects sectors (512 bytes unit)
>>> as input but no conversion is done here from device logical block size
>>> to SECTORs.
>> Yeah, you are right. I think that we can just use:
>>
>> blk_queue_atomic_write_unit_max_sectors(disk->queue,
>> atomic_bs >> SECTOR_SHIFT);
>>
> Makes sense.
> I still don't grok the difference between max_bytes and unit_max_sectors here.
> (Maybe NVMe spec does not differentiate it?)

I think that max_bytes does not need to be a power-of-2 and could be 
relaxed.

Having said that, max_bytes comes into play for merging of bios - so if 
we are in a scenario with no merging, then may a well leave 
atomic_write_max_bytes == atomic_write_unit_max.

But let us check this proposal to relax.

> 
> I assume min_sectors should be as follows instead of setting it to 1 (512 bytes)?
> 
> blk_queue_atomic_write_unit_min_sectors(disk->queue, bs >> SECTORS_SHIFT);

Yeah, right, we want unit_min to be the logical block size.

Thanks,
John


