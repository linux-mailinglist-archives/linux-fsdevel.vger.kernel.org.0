Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DBD6EB78F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 07:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDVFL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Apr 2023 01:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDVFLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Apr 2023 01:11:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3A01BEF;
        Fri, 21 Apr 2023 22:11:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33M3wUBn012003;
        Sat, 22 Apr 2023 05:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b4tEBammvyrvb+GUjcnY6vblvRFhOx1gAT6uu/MtK6I=;
 b=fj0EvHk1wWCPsOavx4rsbW/murL/tGecGS+2t56epinK2HZcT0FnYJZWnnVj9Dck7zBn
 nfeGhOYTyyf2GCqm3xxtYOcxfVdOzoqjd+JpJKgC48JZJAvyyM3+1xC8MfNzlR79Bqvt
 VEWvjEZVyszr0C87f0Ah0uNkbUePeOt+TQCnRaJ0csMokjKrTu/A2EV6KzTM8G3DiD+3
 TCCNbZGQuPfskJ1me9qTTtNGx4JrysWGTPHx8omNRTkmyYnPttuDij4eVtG70s6Hgu6Y
 Byu4fpsiPL+RdRbqr56sCBNI7J99q9JOkL767x5F/3kc27qgqINfcc3PB4mR0TotX9wY 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484ug15j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Apr 2023 05:10:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33M1X0ib012755;
        Sat, 22 Apr 2023 05:10:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q4612v9ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Apr 2023 05:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJHUIuExt7m4t+hdzELKQiAt3hQ8OMV4GQlT8PbkEm1lf4j5m5HK0f02B66kXxVN680tytv8GbsVE6VgypHQuPAShuVCsrq8Iyv5URVe22VbuqnqUx+HoqtWM9Xc/ICLuVSsAKphmu7sNNAs22D3JnKjymy1uFYmA6kLvKZG+w8NXfNQ7ybmPJ/WQbeZP/ty84zfYuL8gfdfAkUWfWiarsHKIczK9GKhBMegyhomjEA3e/tUSG4N2eHSjSaJ8ge6O9YWjMNG19GIHk2HahlgTyS1LmcI6dAGA1N5OghfoKcrAI4t3dux5yYSHMMbGw+7DaYcsYQFNOp0+w0RmS/x7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4tEBammvyrvb+GUjcnY6vblvRFhOx1gAT6uu/MtK6I=;
 b=Z5a4pTMQqLe6hcGYmjwuTF0UWtIGvLKqL3Srjcge5lIpU9fJpNQZp4JTo0HMk37+a84C3ptQz811KGfpG+KkpqZqlc0NvyUsHXAfA8MYcnTBV0if9lXqoEwlqSIecs2/HNJQa6gGgZ2tt0bnBblwxlJFTOOlLsCwJYh7LgM6qEvBJGnLd3yVedPfBuyQUPkMikNnmSYgsyeO19HP4ujPprwQS9Np8l2bnTZ5djf4rMEF13DWsWZpZk97Sg0dIxWHFL5yOveOhp0vTf0g4d2mJpJngzbIAyTPLxfvi4ATD0plUmIVkBiFUH+2Uyr4njF4ksIULmsj/r/z/ODHCgEoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4tEBammvyrvb+GUjcnY6vblvRFhOx1gAT6uu/MtK6I=;
 b=BuLLkUwvDLanN6yGEmt7yikPXhOtbpAA6hi7qnfVxLgMmQmpz/YijlpM6YKhgJrt1H23nYggwDDGHbi+x/yxENdx5evwyNHZDO/j4aTdvtO9nkW2EuVtzJTj76+j2AgWPxQpsrRZn3vLOhz5OYYULKwy4GE07+DEPkxwyPbDHxY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 05:10:46 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 05:10:46 +0000
Message-ID: <42169da4-f453-af92-1c1e-76e65346c4af@oracle.com>
Date:   Fri, 21 Apr 2023 22:10:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 8/8] shmem: add support to customize block size on multiple
 PAGE_SIZE
To:     Luis Chamberlain <mcgrof@kernel.org>, hughd@google.com,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-9-mcgrof@kernel.org>
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20230421214400.2836131-9-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:d3::23) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6d2f95-bb76-4bce-aabc-08db42efede0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mz7pfNjPUdyt4/jQnJtsXBT52YSFR8zfpGQs1gMsZhuMct0rujgCkWT7o4+Bt2X8n5Z+VS+WpUq+TSLTA5zHhlBl6Y92AE0dK+bPh+YwBjcpEw7h5f+tw77Jer7xCB6IzI/SQW3KTb9vYNr3cn7u4AVV7P1XXZXYWRodyrbfk9ugOI9GMipNV/imYbkrKOIujLWZFcb1XxPTc4NrieidvWyqT7hJdGapm61FrLOV4qQ9agVu2IX6g+96/EuboKnp4miCpjdOtDUWVVG+LvtCbLbV6dH6wMMOYoXYwTcMgPNGe6uX9Z/mqBhi5hWogtSMdDO2qhbUs2UM6tp1daSjlE7dsDp75SQXsFLVVz4zpWp3hRFhTMk1z/X03VJ6SyNd3KCaPlQp/yioVudtos+bcqlGJNYAx2Y8JN8R8Hcda7aLilReCd2yFRa+HufAzC3d7s94/kyMgzXwz+JqBRKkB0wzAp4mOAubodP4v6idynC+/rHGtOFSS0ApBPQaFeiZ7yCZBpba3H6rHEhG2ZoMX2PZGzGmhIL9ut3mwbQc1eBz9z94pCNtu6gMwMJv40XhArWUtZMHJQwODQnYFtG2T1OW4sc2sHJqbZns+WK20rmqAV9O14Bysg+ajhjvlGBs5dHbKAcY5GWcdR0c81LOgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(31686004)(4326008)(316002)(66946007)(66476007)(66556008)(36756003)(6506007)(53546011)(26005)(83380400001)(6512007)(38100700002)(2616005)(186003)(8676002)(41300700001)(5660300002)(6486002)(478600001)(2906002)(6666004)(8936002)(31696002)(86362001)(7416002)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHpTU25MZkpaeXRVRVVaM3gvdzdTK1hUejdZSEdwd0VEZGxFVXlscHNKVVl3?=
 =?utf-8?B?bEdvT2l1aVgxclR6K0haVDlhbHBreGNQb2t0ZHJySDA2SnlkTUoyRFVLNnhw?=
 =?utf-8?B?VVovUk5QcmJwd2JtNnkyVVJBV2lQR0FoaDNEN1RVUmlrM1dqWTNxK1hjL3Rt?=
 =?utf-8?B?Wk9zNzE2Y1FEYjZqNEE1cklCWmtrWllndHhSS3h0Q1RlaFpQa244dDBpZUN0?=
 =?utf-8?B?bzdseUhiNGYwU25xZ0Nia0tFbHlZQ1ZHZlUweGtCb3M3d3FGaW5rbU81SDFh?=
 =?utf-8?B?TG9MblZNRy92ZitubmVWZHlnRDNvRzZoN2pBN3dNdXNqa25Ta3d2c3l0T2Rw?=
 =?utf-8?B?aU4vaW9OUDFKWjZvRWlObnNVWFNaWDRJY3ViV0VaQ0RnNjNYZnlqQW9zRTNm?=
 =?utf-8?B?azF3V2pwQzdRdHF2akh4dnNibHRFVWx4WnZvYWtQc0RDMk0raEM2RGxzV2hS?=
 =?utf-8?B?NFc2S1IwSXp1akFxZGl0UTBiSUNMZlNPNndmbFZxRTM1c3lmNndFNCtDcjh1?=
 =?utf-8?B?Q2QxVTFNOFpMQWlhUUdaVGxWZ05yZy95dGZXNlN0YUorTjVjN3dZUURJWVhr?=
 =?utf-8?B?ZWpLSDEzdW83c1haeFQ4OUJzU1gzUU5EMnovYmc5dzRCSGI0clo1c2dZRXFP?=
 =?utf-8?B?d2ZuS24xRUJ4VHh2WVRBeExsOFFZRWpxY0p2Y3hVQnNQWGFld0pOODdIOE9p?=
 =?utf-8?B?Nmd4S1lEU014YUxMVm1aQ2FhN0FBLys2SFhaYis5SkRITUtXZGNod2tMVldr?=
 =?utf-8?B?cmRPN3labktKY092SHNBSjFITE0xMVdsUkh1c3B2STZkN3Exd3FRYmExM29X?=
 =?utf-8?B?c3JNeGVCNEwrWVBYWXhYa21EKzgwalFBZTVKVCtZeVhaeUVkOUxNUW8wVCtp?=
 =?utf-8?B?RmgxSy9GWEw5RnFVcXJqVldvV0UyLzNlb1lTcDhwaFJOMlh1RWNqcW92bU5N?=
 =?utf-8?B?bVRPR2ZUVTRyYkVUbFc4cGVRY2dvSTlBbk1tWU1ybGFOcXFXM0JEclNNeWxH?=
 =?utf-8?B?cVI2L3ZQNHoyelNlZkJRZTBpQ3Z4WVNHVm1XK1NwQmIxV3YwZysrZ2dTTUEw?=
 =?utf-8?B?OFpLTEJpZ2NUVFIzZUt1K3pYTzZlQjQwMzBpL1FWY1JrT3RYNkowVXRsTTZ6?=
 =?utf-8?B?UFZsUzkzMXc5RDdpdURzOWpLWE42eVhleWtFTTRubkYrNkNFOEw0alV6N1lK?=
 =?utf-8?B?eER1MTRNVnpHZHI5WWtpRTdYdTRWZmtEbDBxc084VkRLd0RuSGdNYURNalpD?=
 =?utf-8?B?TVMyQyt6V3RFN016QXo3L01zV2MwZHNUS3dxVFFzSUcxV3pjR3RLcGlqS1Z2?=
 =?utf-8?B?bzZmeDZJMkd0YUhRcFo1N0djRjNianE3dWRaY055bXpFSjVaYk1QNWF0ZVhT?=
 =?utf-8?B?R0l3SXNmSW96cVFnd1JtZGM4VUFjQkYzWjE5U1VvSVJxN2hiR1p5VmFLa1RL?=
 =?utf-8?B?Vmo0TWhlVXN3RGlqc1ZVQTJac3FpakZNSTMzRjhpL0EwWlk0azZlYkR2NGNy?=
 =?utf-8?B?djlyRFVUM3ViYnFqc0xBTDlpN3ErcmxaNHM0ZmV3SUFXclA1RU1wOEg3Qkdw?=
 =?utf-8?B?SGU0V2ZBR2Y5RzMya3JLdWZnWWxSY3BvcFBTMlhvb2JBUWJsM2Z2MXc2Qis0?=
 =?utf-8?B?WkExZkFiVWlvRVpMZ3FlTlp4c3RwbkhSZ1Z5UUpZVVhNZFh6azAremVvbXBE?=
 =?utf-8?B?QU1HUWhicEtWcjg3eHBpdzFSYTMreDFDZEF5UVBsUi8ydEN6UThNNmNzcUJ4?=
 =?utf-8?B?Z0owN2ZBc0Q1MnZoRkh4ZTlUVm55TnZwc3B2N2lJNjhKQ2VNMVB6dkdkdnhR?=
 =?utf-8?B?TVFab2x5L05HMmttcS9LUVdvOFVLVVJ5d283eVcwRW9Qc3pkQ0dGbUk1ZDcy?=
 =?utf-8?B?RWYwbUU3RHpWYTlVVGZBeUNWQWFXYittbWQwNUNZOExIZ0Q0R3g3WTB3Qkkr?=
 =?utf-8?B?eWxZY1pXN2NvNGNLNWhrZkRaNE1oYTN2dTMxMVpUQnlrUXNnLzl4QUJtZWRC?=
 =?utf-8?B?SlVNc0QzbXJnNS92bHljRjluekZ4bXQzSkJ4WkUrOFIrbUY3UTRvYVMzWStH?=
 =?utf-8?B?M2hsdXJac0ViNXArVU5tWld5MWtEN3RvOUdySlRPUlhqMzBtZEFhMENLZnY1?=
 =?utf-8?Q?Necbqb+FH4yLDqI4w7zX9ueQ6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDNpQUwwamZEZitwWGxnS3lPdW9ZaDY1VE1GSTdYanBKQW04UlJUK3l3QkdM?=
 =?utf-8?B?UU82TndkbmxjV1NMNUJ3Y09Oa1VNY1krTzBPQnAxaWhTV3pKN2ZCRXNPejJ3?=
 =?utf-8?B?TVRESnlCTjFMMW85ZFhMOXYrTndZd3hxOFFQSU1TQ1dqTzZCWHM5a2phK3oy?=
 =?utf-8?B?NXJZSUl6N25jYlBlYjQybDZvUGFWL1N5NDZGVlZvVUVOMUFTUlJuazVyNnI0?=
 =?utf-8?B?YjgrVHZ5d210YVdjT3gvd2dLdUVENmFCUXlsdmlFUE1UOHFWMnRSVmpYUCtS?=
 =?utf-8?B?THdCVkh2TXdycE91YWRkRUp3cm9QM1N3OTFKbDZ2bHpQYUcwYjJyOFNIb3k1?=
 =?utf-8?B?Ryt4ZEZ3dFp2UWhMb3N2d2NITVllZHJ6M2FMRXRQNWY3SkZOblh5VU1Na21T?=
 =?utf-8?B?K2hjejBnMHZrNUo2ZXpaVXhlK2FhZ2lERmRvais0WDFQcHFMd1FYTEdWbHlj?=
 =?utf-8?B?TU95T0ZNSG5hS1JqZnlKc0x1UlBBRmF1Y0JSUzdMYXNEeTN4cExFN3YwYmtj?=
 =?utf-8?B?VG5iV2lYNXZaeDNta1FjSDZrZm0xZVpmTkVzcThHTGJua3E5MGtjZElCM3Bp?=
 =?utf-8?B?bWRmb04rc2l2d0VCUDRLSUtSMTI2cG9qZUcrc09FL3h3cnQzd1J4UHRqZmdK?=
 =?utf-8?B?cGwxaVBoOGtRQUVtYmRZS09WMTJGV0grWnNvK3lXajg0U2JsbVlMUExERW5p?=
 =?utf-8?B?Z1BIcERjbHdLQmQ0RVJWT3NUd3BNSTlJT0JwdTZnZ0xsNlAvc0FRUS84UlVY?=
 =?utf-8?B?VGNCTDd5dWIzTi9CNk50S0JrT2JQVnF4UithV3Bja0pTdG84NmcyVy82VXpk?=
 =?utf-8?B?RTc5dWF2WlEyRXk1bGZ0MlJucXNoUkpGSG5hYnBYVlgxRXJaRFJHbyswd0Mw?=
 =?utf-8?B?R3ZVdDlVMDJLZzNwZ2orV1BKWWhBUmloWVV4UC9nRTNIRG9PL3FSckRieGRl?=
 =?utf-8?B?L09NZmQxZUZianhkdlVJdzZwL01EaGprbnJhWlJyTkdnRm9pNlZwcGNnbkxl?=
 =?utf-8?B?THZGNFJkWmRMUnV0Q01mcjd4SDhmZVlTSXpPMUZuaVoyOE9lMXZ4Q2x1QmlQ?=
 =?utf-8?B?Q1RVODg1M0tZaUdBek5PM2JHYW8zMnZMcy9wRnRPV3VBSlJFYU1WVlVJazlW?=
 =?utf-8?B?RHlxZUp2bkJUQklKT3h2c1p6d2MyMWczbU5tUnlLZy9scVBoTjRlTFlMNzhH?=
 =?utf-8?B?YTFUc3NlaS9GY25CV0k0cDNjT3hQOCsvTTlDcEpJTE5GU3gyaU10bmVQQTh6?=
 =?utf-8?B?Y2wxL0RsdzJSY2N6aGVzVmFXS2ZDOFFLaUd4SHRYdzQrWkxrODFadEhwMlVZ?=
 =?utf-8?B?cURTL3lHam1wRlF0dXdna2hiQUIzZzZLRGliNVRUREQzSWswME1iVTF1ZGVL?=
 =?utf-8?B?eHJheUZWNmMvVmUzK3N0eW9qcUcvQThEOUtEbGdhcEZtVFlPUnArVmdMVlBY?=
 =?utf-8?B?T09GMDVtQm1rdkxPbHcrQldocVJjLzgrRXBqMXZoV3FLV01tNnNqbGJHVmJZ?=
 =?utf-8?Q?Ms4A+w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6d2f95-bb76-4bce-aabc-08db42efede0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 05:10:46.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGFAN9B0sFug22nM0jrluIsDWt7EHn1oEIhpsqxhEbEM0guV5iFFOBRfb6ftMmLGHRvSjuU9njA/IxW+dRWn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304220047
X-Proofpoint-GUID: -x80ccYHPoUcbGfWi4wD9EFTi2aI1x1j
X-Proofpoint-ORIG-GUID: -x80ccYHPoUcbGfWi4wD9EFTi2aI1x1j
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/21/2023 2:44 PM, Luis Chamberlain wrote:
[..]
> +		/*
> +		 * We cap this to allow a block to be at least allowed to
> +		 * be allocated using the buddy allocator. That's MAX_ORDER
> +		 * pages. So 4 MiB on x86_64.

8 MiB? since MAX_ORDER is 11.

> +		 */
> +		if (ctx->blocksize > (1 << (MAX_ORDER + PAGE_SHIFT)))
> +			goto bad_value; > +
> +		/* The blocksize must be a multiple of the page size so must be aligned */
> +		if (!PAGE_ALIGNED(ctx->blocksize))
> +			goto bad_value;
> +		break;
>   	}
>   	return 0;

-jane
