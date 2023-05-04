Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AC6F71D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 20:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjEDSSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDSSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 14:18:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DAE4E;
        Thu,  4 May 2023 11:18:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Fs2ar024876;
        Thu, 4 May 2023 18:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WMDHsjcLPe6GWiTmqFYf/ioNx83pizHCO9xh4cYqW6I=;
 b=n0FhvZugokb9aSBctRfgLi/l07ugWZwi95nb0D8SvwMkHMPYqqeSxeJh01rGluTOuaRX
 mI2ZYUkHe0TDcc14JLLkuhofkTtd8bHrJkGqY5wagAarv5HKNFw5ic0SKZBfYIl+4dtc
 gEWScZDZLwK1K2nMPYzKNGZP+SIVyVxPa3BbPZ1eltdjOZjb2S9/++PuVJpgJ96S8lkL
 nKlPGQbtQ7oN2pzQ2qU32apFCu0+8OxjE1uuAYXddOt9oJ+18PizXPKnMpFUU+QKYFV3
 f5QBzPqlSVwWIwjySjEl70hrUo1VoBCOm9WmZq/NYRXGMvzxgCjmXqkN35ZVEs03P/y9 gQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1tkm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 18:14:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344GxlHL040517;
        Thu, 4 May 2023 18:14:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8w2mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 18:14:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuZ1SF9OGtn/wyT3n0yiuZZzRf5Wrw72MkJm+RiIjh1ruqN9TXNi67DoznMnaBG/B5dw7nJi/d9IQHN4aRtTYQ20No7QFbD1vF4ZCg9Jh1KS9y1jtkqWVtDGBeJRqjXmE3vTSZPDzPtWND7wOEDtcTHfrMc1xnGsOdHEb/e5KJ9jiKC+eOt659w04ct/Bz1ZQWpcK+3oVenqA+vBDZEXHo3iVer8241nyxFrypkKgBMLJzrgU2j8GAlVi5D6+CXGSHaYTpfO+PUOMYdkfFS97N01yyI8AHSddD94iwtASQZR5nJQDK636fKBbzaFE3RQP0I6p8tVK1R3LKpWFp6jZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMDHsjcLPe6GWiTmqFYf/ioNx83pizHCO9xh4cYqW6I=;
 b=J6XWVLbJbDox5qhPQBgu5m4oqUgzMSDEgTDGmj++CMVm8VmJKvpY9AGoxRVGOM/LBhp/61RW7PBwC/cc3lER9KgcIPEGgsK7JwjFyp6hEQNcGFGNCIubj5F+lBsmnKcy196ZO7qytFsdhb5OmYM5f60RZ+yECKThewgKiNAv7lLEwnpoESjO0Xxg29ozRU5+czzGd0NA3Dkcn9m+n0fh2v+AfoXIrB1CGXHVUPiLyYDjb9JQQmXBTp2jRKICzbr+tD/njtfq6YVoFJ5FRjc8doX1PGYkRDQT7AX25aBUIk8M38M36CvXm3fCBIJzGuuR6irU22/WzNwU3IU2GEFpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMDHsjcLPe6GWiTmqFYf/ioNx83pizHCO9xh4cYqW6I=;
 b=JbT7LC4Ve5u/ssClKwb11/zLKxL+b1cFIrbEM3LphSnqHkYSvSVisAbUtSgVGXCg9FMuTr/1pU6dnAAj5FVVx+pN0//6UxyLgHKnha84+pKTaL7LTjuRyL+V5s3djri0Sl4qlHaykAosofl/32k4Fvmv4TE9PSWkXq1fYeXFYc4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 18:14:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 18:14:47 +0000
Message-ID: <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
Date:   Thu, 4 May 2023 19:14:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230503213925.GD3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: f898cc03-bd19-471d-788f-08db4ccb715c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgPB1I50u7QGdxg+FAlyX/EaXYsehvUd9kFlyfjb/fS9nAWExYAEvtC8qO00aLSU1QWKXlY61g/Z1jiIobKfv8EEUa711yjpIUKdsaNHkjheccT7/EPjBWryU0Zpi3INB/8eVIDncxFKPq/x9oZwRTA1UcESCCeXYvLskF4y7/il2goACWSL2D6837GlqDES39VshuY8bXVkUuL+RgMKkSBhPrSEbA54gMkUysTsymg8XKqj+SAf/hDxSou7fBkTwYeD9bYsX4VNtCuwNcMi2K/kAvtYXEhgVUXOXhmBY5aeAELY6HVS+hakWj4LtHgEo0ZTfj7KyNCAp2HlwSQ8RFvVKwzpAOOk+fOPpUsMDY5WSOzxysgtUgL1tOrFNnRkXWh/lj1E7n5Pi8UcOFIrd2G/KYJOFRlbdTSh+urBF8SNTLwmrvEOWJjl3YQNlwNxb9K0kBnYz76mGpeKkeE+E5JoqEMZBhWrpVhblo/wZxZ96gIU+5tKPH/KNf1uoctL6fv8UDTmpz2+bgv6nLgLtEZjCX9JnPvxppOtad6b7T+3SnxPSu5MF/DlERtolMrtGnD2gjKPwS+pDKQ2hmG2bKYYxSmtMZoEN8FhYtfaN0eo+jUNAYCBHa+l4VqU+YHt2JTyvktKU/g1h80crVinPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(478600001)(2616005)(6486002)(86362001)(36916002)(31696002)(6666004)(41300700001)(316002)(5660300002)(7416002)(8676002)(8936002)(38100700002)(107886003)(66946007)(83380400001)(36756003)(4326008)(6916009)(66556008)(66476007)(2906002)(186003)(31686004)(6506007)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhjUnpsRWh4czBwMStQT2NkdkR2dlhobkRQZWd2RGpVenI0eDRObUVnWThO?=
 =?utf-8?B?blZmVUJibmgyMTNhOWpUZi9QZVhxUDFMaXRsdkRRa1dCYW5DRmpLd0xSdzBK?=
 =?utf-8?B?UzF0Qk1QK29BZTBwMkJCWUhaNG1MYkkxeWhzZGdpRjFyem1HeDU4QUU3YkZC?=
 =?utf-8?B?U1ExQitOZ05LUmdkRlpUeElnK2RqL0ZJS0hRa1JDbWtUaCtreVJYMmVtK05l?=
 =?utf-8?B?MXFLZmRNbUUrQXJkK05IajMzZ3JwNzU2MzB6c3J0VDE1bG5YTjhNRWM0RFpY?=
 =?utf-8?B?QVBJSWU5dWpZRTRUZFVBOW4xcDJCZXJXanJQTmpTeWthZWg3Z0ViTkhoV09z?=
 =?utf-8?B?ekk0VUQ5dGY4aHZuUnVsMThhRThRL2lmZlVxL25DcG1rWCs2T1NkM3Y4UzVz?=
 =?utf-8?B?dlZ3V2hnL0JCMXNZbUJ4Y1hJNmE1ZTc5RXVKa09nUGtBU3lkbzNZYU1xMjNq?=
 =?utf-8?B?NERZbjR0Rjg5QXpXMDd1OEhDcGMyRFlRNHlxazhhNUQ5ajlxdWVQbDV2RWo2?=
 =?utf-8?B?Nm4rdUxoSlhkd01zVVFsWDFKK0ZsVWJvSGxPQTBSejc2N2E2clhvdDRpc3I0?=
 =?utf-8?B?UzdxaTZRYk12MkNOcW5Hbm9mdEpBcWE5Y0NGWmNpOUxpc0tkNzkzUEpLamxt?=
 =?utf-8?B?cjlhNFhYT1NFM1FiMjVCQ29WY0NycDZPUWNIMU1sTFRtbC9POWhHd214bmVs?=
 =?utf-8?B?eWE4QU9hOXkxZllzSE8rekRGNE9zM0VPb1VOOGE1VHhGd1YxT0tYeEFDWGIr?=
 =?utf-8?B?UmplMThBc1F5dTE2b3lMYTF3aG85MjVCblVuMXYwTUN1R1IwMDZuQWlmWFdo?=
 =?utf-8?B?c2ZXYkoySUJhbTN2OUhkVkZURGpvRGdpME5IWDhXek9KWCtZbFhjcE04NHJP?=
 =?utf-8?B?dStyNUNSamtBaFREeExvaUdWQmpyNFh1QzVabVU2TU1QS2xvL2I0YXd6N3hP?=
 =?utf-8?B?bWhTcmF4dkhwVVVmejhKUXhBOXA0MUM4dDVFSVNvRGw3cSs1Z1h0RFpzUmRr?=
 =?utf-8?B?SFpzUzBiRjQ0Y2xuVk12RmNrSk1iTkJ0VUFWdjUwdG1PYlJ6NlZHd2x0UUVu?=
 =?utf-8?B?ZGFRWUJXVVhjYU1hYlhtZGY5cmZIRTFCdGR4VWJVZ2FTNjc5dlBSY1N4Vmhz?=
 =?utf-8?B?M3RXY1RkNStpTFJxTElOWFJUc2RHdTJOTlJoVHZ1OGdqMXFoV3kraWF3RzZS?=
 =?utf-8?B?OHZwa3dtVkZGTk8vYTE4TXpwejI4dmM2U29zejhSREZCM2xsV0FyRFFsRTFQ?=
 =?utf-8?B?SXJzQkhsSW1uSVlhc0psbGx3YktmZmFtL2NvN2FOdmdlc0JTeWFrTlFDUUNm?=
 =?utf-8?B?YkY3aU9ZR2xpVHhpODRVV2I5NjNyQmZSV3Fqa0FUSldQbzhUMHRPUE9rM1dH?=
 =?utf-8?B?cWxLdUZaRklSdXE3b3B6WXozZFVtRzRyT29qZGpGYlk3dG5sM0RJQWF1VTJZ?=
 =?utf-8?B?dGwyMGlhZit2NWpTcEI2VG5oOHpRSnJ0cm1nYXhCSFZhR3A0YWx6WklqOEdS?=
 =?utf-8?B?TmRjWmN4UGRyZVhjNlBmeVZuOGtUNU55LzVXM3d0ejZCY29zZTdYMEVVTHZD?=
 =?utf-8?B?UWdZR3ozQ2g2bmdGUmlOZFNaNW1NRlRjM0JDRDZzTnBGYjExajZKL21idnpM?=
 =?utf-8?B?Q0tPTEhJSFhWck9qRjB2ZS9QM3BvNmNYdFdxaE5mcFlQS0t5RjB2ODlwV2Jv?=
 =?utf-8?B?S0phYjdBbG56OTcybkZ4bVhBVHkrM1F0QjlMbUttcyszTzIxNWw2YmxYVGQv?=
 =?utf-8?B?UkNIejdCUmp4WjJ0c3dXZFoyK3p4QndicWRkSkRFQ0pVU1h3RGJrZHBaTnZ5?=
 =?utf-8?B?aU9YQnRreHBWWjQxS2U3Qy9NUGM0d2dhQkpOcUpJY1VPVmg1U0dncVMxQ2Z0?=
 =?utf-8?B?cS9MYjczR3pkTVFXQ3NldHlEdkt6bHdDc2cwOWhEeG5raUhnKzViOU42M1cx?=
 =?utf-8?B?eUVKTE5VYlgzRU1jTlhUNWZrTyt6VFREMnBVRkhwM0kzY0NaN3NwZDVHbG81?=
 =?utf-8?B?WjBCdTdjM20zZm80NVl0TTg4NVgwVTFJeEtjTFpFbUE5aHZIOC9tY2dnNnE3?=
 =?utf-8?B?MnBDM1BlVzQ2anI2cFpLWFBFWjQ2RktGWlRGSXJ0M1dXbGhCOG9ra2JiOUU3?=
 =?utf-8?B?bGpCMjVOc25JVmd1dkVuUnUyZk9HL2p5MW5FSExHcFhiamY3Y3JNTnZHYnhM?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlZwcFhDQmxKUFZhbHBPRzMvRkJWTytFMGlrOGhTL2NzQmVVVGs0RlphUCtw?=
 =?utf-8?B?WkxPalpkSTlwMzl1Mjh4NStvd2pEdFoxb0QrWDBVR3RMVG4xYjdiUWFHRjQz?=
 =?utf-8?B?ZjBGOGZtV1pvd3IwZkxydDNMYkF5MHdoOEprOEp4bVczM1dxWTRGVlNlWDdn?=
 =?utf-8?B?UGlIN3FsS1RkSEY4Zy9Pa0RuUlpnQjdUdVRaTzN4cDZTc3ZySktoaWR4dmE0?=
 =?utf-8?B?MWJLNHBVeXh6OTg5bnBtelM5L01BK2lramo4cEIvK0FXNHUwY0lVZEQ5Z3Nu?=
 =?utf-8?B?MS8zdkloNGpmVlRIa201Z21ZM1hrQXRpNFkwRW45VVR4TGZ0MGtlN0hUaklC?=
 =?utf-8?B?MU94bm9Fa0lIRW8ya1k5alU3cis0SEc1TUtCQ3V3TTdsK3VDNDRDTDVGSnhY?=
 =?utf-8?B?S0oyRGVtMlVMSXI1ZXNvdm1TNnRTdC9XeWFZQVBGK0wvbkE4bXZ6WHN6SnlY?=
 =?utf-8?B?VlI5ME4waGFjd0VLOW04UDdxbDh4VmthbGV4bzF3UGY4R3NGVUs4SEdiYWlJ?=
 =?utf-8?B?TXM3VzVjT1BUZWV3NjhlR2svR2hsZk5DYzBkbFdvZE5FUytjS254MThpU09I?=
 =?utf-8?B?am9TTUJlRklpdXF1ZGRaWkRDK0dRS29aVGRxODJMc1RiMVZZM3ZvMDFhRWJ4?=
 =?utf-8?B?TGs2VWdRdVhwamV0R1RVSDBFWHZWT3N5ZUIyaDA1aEw5OWFJeDg1a1p3WnVh?=
 =?utf-8?B?ZTZ6RWMxNkd5OUZvMGdaVDN0U1l2ckRiNkIzNEtDUmNZMURXbjAzVGdXQXlG?=
 =?utf-8?B?N3JXMnJzSWdsL3hFT0tySEphZHI5SkhhbWY2c1dBeit6cDFUb1NZY05XbSt3?=
 =?utf-8?B?S004VEQyY2tXRFVCenlNclNhbHB0R0E4VGpvQU9mczlWZjVaV3RuZEFqZVVi?=
 =?utf-8?B?cmQvSjRzd0crVGNPb0JIbWNvekRNT0V2aFZnMkF3WkdnSEFBWXVKMDMyMWU1?=
 =?utf-8?B?YWs2S1orVmFCTlRFODN1WFNHclhTWjM1Mkx1SGhvbjRvdTVDaTdmZ1pEekVu?=
 =?utf-8?B?QnpWYmdIVEFZb1k0S0RHQjNIcTA0UmNPZk52Uit0N1lnRUNBTlhBcUJoeXBH?=
 =?utf-8?B?ZmNLK2UwUEhKMnVvMCt6ZGNxaVlpZWI3b3ltaUpDc0RrUlhycXQwdzZNQy9n?=
 =?utf-8?B?N1hvWXRkVlROeEtpMURCc0NPY0F2Zjh2WTBwSHBiYi9SRVNVaE0wcUwxelNG?=
 =?utf-8?B?bUp4RzlLa0g5MTd6clVhVXA4NEpzcmlQaUtwT3c4dDk5RHdycnp0S253RjlX?=
 =?utf-8?B?RG9PbGJJRDBZdU5mbDBsZGsrL0pVRGtWVk1zRGJFR1VwSFc2WldHbmc4NXVs?=
 =?utf-8?B?YjBGNU9ZYjZJekpWdnlVc3BDU3UxN2tsZzZzaVpoNE8wUXB2NStjazZ2bjhZ?=
 =?utf-8?B?WkxoZkthN2Nra3BjUFZDMG5vTjNLVkIwREt3RzJCVGFTSGVNQ3g0UFZvV29J?=
 =?utf-8?B?cVN0YVBzTkVSNEI4TS9QcVZrQ3NPdUg2enFvVXgxYWRXR1VJcXJubVVEc3Zm?=
 =?utf-8?B?KzFsdlRoY21PSjM4TnZiak1HM1ZrbDFZSzI1UnExdWJHWDNUYXByK1dSQjA0?=
 =?utf-8?Q?pTkE4kytA8uZMcOSWCc+UPcJc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f898cc03-bd19-471d-788f-08db4ccb715c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 18:14:47.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVujsoujIugVhxemPV6oKemYNszRpSeiKyYNwFfp404EdPkUylWJv7k+CqR+IlugPCndnDYjTC8cQi9f8MtmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_12,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040147
X-Proofpoint-GUID: SM0gglqFKYuZWXndTMaVj6280GHJEkO5
X-Proofpoint-ORIG-GUID: SM0gglqFKYuZWXndTMaVj6280GHJEkO5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

>> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
>> index 282de3680367..f3ed9890e03b 100644
>> --- a/Documentation/ABI/stable/sysfs-block
>> +++ b/Documentation/ABI/stable/sysfs-block
>> @@ -21,6 +21,48 @@ Description:
>>   		device is offset from the internal allocation unit's
>>   		natural alignment.
>>   
>> +What:		/sys/block/<disk>/atomic_write_max_bytes
>> +Date:		May 2023
>> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter specifies the maximum atomic write
>> +		size reported by the device. An atomic write operation
>> +		must not exceed this number of bytes.
>> +
>> +
>> +What:		/sys/block/<disk>/atomic_write_unit_min
>> +Date:		May 2023
>> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter specifies the smallest block which can
>> +		be written atomically with an atomic write operation. All
>> +		atomic write operations must begin at a
>> +		atomic_write_unit_min boundary and must be multiples of
>> +		atomic_write_unit_min. This value must be a power-of-two.
> 
> What units is this defined to use? Bytes?

Bytes

> 
>> +
>> +
>> +What:		/sys/block/<disk>/atomic_write_unit_max
>> +Date:		January 2023
>> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] This parameter defines the largest block which can be
>> +		written atomically with an atomic write operation. This
>> +		value must be a multiple of atomic_write_unit_min and must
>> +		be a power-of-two.
> 
> Same question. Also, how is this different to
> atomic_write_max_bytes?

Again, this is bytes. We can add "bytes" to the name of these other 
files if people think it's better. Unfortunately request_queue sysfs 
file naming isn't consistent here to begin with.

atomic_write_unit_max is largest application block size which we can 
support, while atomic_write_max_bytes is the max size of an atomic 
operation which the HW supports.

 From your review on the iomap patch, I assume that now you realise that 
we are proposing a write which may include multiple application data 
blocks (each limited in size to atomic_write_unit_max), and the limit in 
total size of that write is atomic_write_max_bytes.

user applications should only pay attention to what we return from 
statx, that being atomic_write_unit_min and atomic_write_unit_max.

atomic_write_max_bytes and atomic_write_boundary is only relevant to the 
block layer.

> 
>> +
>> +
>> +What:		/sys/block/<disk>/atomic_write_boundary
>> +Date:		May 2023
>> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
>> +Description:
>> +		[RO] A device may need to internally split I/Os which
>> +		straddle a given logical block address boundary. In that
>> +		case a single atomic write operation will be processed as
>> +		one of more sub-operations which each complete atomically.
>> +		This parameter specifies the size in bytes of the atomic
>> +		boundary if one is reported by the device. This value must
>> +		be a power-of-two.
> 
> How are users/filesystems supposed to use this?

As above, this is not relevant to the user.

> 
>> +
>>   
>>   What:		/sys/block/<disk>/diskseq
>>   Date:		February 2021
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 896b4654ab00..e21731715a12 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -59,6 +59,9 @@ void blk_set_default_limits(struct queue_limits *lim)
>>   	lim->zoned = BLK_ZONED_NONE;
>>   	lim->zone_write_granularity = 0;
>>   	lim->dma_alignment = 511;
>> +	lim->atomic_write_unit_min = lim->atomic_write_unit_max = 1;
> 
> A value of "1" isn't obviously a power of 2, nor does it tell me
> what units these values use.

I think that we should store these in bytes.

> 
>> +	lim->atomic_write_max_bytes = 512;
>> +	lim->atomic_write_boundary = 0;
> 
> The behaviour when the value is zero is not defined by the syfs
> description above.

I'll add it. A value of zero means no atomic boundary.

> 
>>   }
>>   
>>   /**
>> @@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>>   }
>>   EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>>   
>> +/**
>> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
>> + * the device for atomic write operations.
>> + * @q:  the request queue for the device
>> + * @size: maximum bytes supported
>> + */
>> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
>> +				      unsigned int size)
>> +{
>> +	q->limits.atomic_write_max_bytes = size;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
>> +
>> +/**
>> + * blk_queue_atomic_write_boundary - Device's logical block address space
>> + * which an atomic write should not cross.
> 
> I have no idea what "logical block address space which an atomic
> write should not cross" means, especially as the unit is in bytes
> and not in sectors (which are the units LBAs are expressed in).

It means that an atomic operation which straddles the atomic boundary is 
not guaranteed to be atomic by the device, so we should (must) not cross 
it to maintain atomic behaviour for an application block. That's one 
reason that we have all these size and alignment rules.

> 
>> + * @q:  the request queue for the device
>> + * @size: size in bytes. Must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_boundary(struct request_queue *q,
>> +				     unsigned int size)
>> +{
>> +	q->limits.atomic_write_boundary = size;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary);
>> +
>> +/**
>> + * blk_queue_atomic_write_unit_min - smallest unit that can be written
>> + *				     atomically to the device.
>> + * @q:  the request queue for the device
>> + * @sectors: must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_unit_min(struct request_queue *q,
>> +				     unsigned int sectors)
>> +{
>> +	q->limits.atomic_write_unit_min = sectors;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min);
> 
> Oh, these are sectors?

Again, we'll change to bytes.

> 
> What size sector? Are we talking about fixed size 512 byte basic
> block units,

Normally we would be referring to fixed size 512 byte basic
block unit

> or are we talking about physical device sector sizes
> (e.g. 4kB, maybe larger in future?)
> 
> These really should be in bytes, as they are directly exposed to
> userspace applications via statx and applications will have no idea
> what the sector size actually is without having to query the block
> device directly...

ok

> 
>> +
>> +/*
>> + * blk_queue_atomic_write_unit_max - largest unit that can be written
>> + * atomically to the device.
>> + * @q: the reqeust queue for the device
>> + * @sectors: must be a power-of-two.
>> + */
>> +void blk_queue_atomic_write_unit_max(struct request_queue *q,
>> +				     unsigned int sectors)
>> +{
>> +	struct queue_limits *limits = &q->limits;
>> +	limits->atomic_write_unit_max = sectors;
>> +}
>> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max);
>> +
>>   /**
>>    * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>>    * @q:  the request queue for the device
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index f1fce1c7fa44..1025beff2281 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -132,6 +132,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
>>   	return queue_var_show(queue_max_discard_segments(q), page);
>>   }
>>   

...

>>   
>> +static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
>> +{
>> +	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
>> +}
>> +
>> +static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
>> +{
>> +	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
>> +}
> 
> Ah, what? This undocumented interface reports "unit limits" in
> bytes, but it's not using the physical device sector size to convert
> between sector units and bytes. This really needs some more
> documentation and work to make it present all units consistently and
> not result in confusion when devices have 4kB sector sizes and not
> 512 byte sectors...

ok, we'll look to fix this up to give a coherent and clear interface.

> 
> Also, I think all the byte ranges should support full 64 bit values,
> otherwise there will be silent overflows in converting 32 bit sector
> counts to byte ranges. And, eventually, something will want to do
> larger than 4GB atomic IOs
> 

ok, we can do that but would also then make statx field 64b. I'm fine 
with that if it is wise to do so - I don't don't want to wastefully use 
up an extra 2 x 32b in struct statx.

Thanks,
John

