Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498676F6766
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjEDI2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 04:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjEDI2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 04:28:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE52A4203;
        Thu,  4 May 2023 01:25:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34444tqY023422;
        Thu, 4 May 2023 08:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RLW43Cg4twmEc8q0TpGJ9S5YCoe9271p8PCB2RrYxnI=;
 b=D2Jb4X/M1JdUW9XOzyxn95VRj/MHjFaz3evL7Xi7FnckrM/sxIT/wz+9O1la2/RwAsJF
 p39yNgOf3p3OPBflEPLKq7pZmRxaQie9wc7+62XTWPoGbT98GGfGEGii6Nca37pPR6j1
 gZVhA90waAAfozqUr9tgqGec5z8LRD9J41GQC6pahQbjYFUsTQMZBLP/3iCkkJLtxLp6
 aS7NY80cTRA7SzYgdeL/TGz5otre3vqbVaMQQh7SD58LHNZiIprZx+6zbdHRqaZsE+47
 III50k1rEpLFQYQVejLf7s2au05k59xAXJnsjjznQZGGpCxhjauzN9ojUvLJSZsVIxsC Tw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4as42h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:24:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3447iDRr026892;
        Thu, 4 May 2023 08:24:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spefed5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 08:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyWyJJhNjHn+VCUFxuZw2ZrtMUvSzjSLzfAsrZqtM6WsMpmj3pf1oELEm+JTiup7S1C3ohZsU+ALfESAnGursm/3g78lUafU6eBkaR1qzQCJabkZx6AukqdI1GaS3Bnzj0ar1lbLyN7lTHfo2+rGC+ibBiBAmcd9umzRZR4z8LzJizgDSjBSG0KXnhVKkwP0vix+RbVLmaOLs0COGQsnPnZbq6cbWRnq48UA3S8JNrRo1Xt/R5V1dUvyzCwMA+duP+4Ar/ilPN28Oj9XfBhYRsY0KFYQ5rbuWstzr6K4LjzIJtcZbvNhi3wTdnqJlK78UjWIHDvSJ+L1r+27cjRVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLW43Cg4twmEc8q0TpGJ9S5YCoe9271p8PCB2RrYxnI=;
 b=OPCWCEcpBmn7avW+b7fOPWNZBHNK2TU6BKnjD+0vEgC/BksCrhib3e1ua8bR0ouKyBnhlxznqWHY/AXmnLD8ThVqQyvu4yq3juOuiz1EtVFphW6+HoYhVMVq8hu2eAf8Kcgu0i4dgI6vPwsMowVhAzV7X1bO+252b+0yKyiSRooVggU6+JRW4WdxqsUrPNc6Qd1NiiI+1HlkGGbrTHSpiO4hAhg+EXqi+zKYffJnR/31MzbeI5AvMLusjnxGtci+r3CXtBpBqm3WXnUHaOwKiMofrPQ68b9KER29ruxaNeBheH4XgdssDq1FCrBtv1ytCFxtqDKbUfPikHLP40ly/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLW43Cg4twmEc8q0TpGJ9S5YCoe9271p8PCB2RrYxnI=;
 b=diRwQvSYU4X/21oRzZ9P1et5XZLHYR+q78aoRk79rO28sd73AyPjM8G6GlB2uQK59pXGX25zcgG1q4kayFs2ywT4xYnRAVkVVA9w2KsyNc2/zA793cNn8Z8YpNczvGTGiN0oA6jCx0vg4CvJ4kAReB5k6vsRJqeqY1sVmXG6cRg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 08:24:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 08:24:30 +0000
Message-ID: <a547c675-6012-0596-4175-70c0905de292@oracle.com>
Date:   Thu, 4 May 2023 09:24:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 06/16] block: Limit atomic writes according to bio and
 queue limits
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-7-john.g.garry@oracle.com>
 <ZFKtt2Z5BPyV9gHJ@kbusch-mbp.dhcp.thefacebook.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZFKtt2Z5BPyV9gHJ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: b83f1fea-2c06-48be-9963-08db4c78fb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7A3qAxxGGLcK/PjMI+75GGCb1VySY2b4zm7yBV4BL/sUkqmWBZaFj2KEHvEL79GjflFLodSHgVcEn2gKPbF6t+2O+uTmciY5si0oYQdbJCvcZeT2+GJu9ZWe13hOU4eNzEByFogNOiCGqNIBNvPTBmGm5HSYH1IgwdnaUXAOt6kofGWJ1kpW4fUrMz4RyD3sy50nHzvHRfsRCoPbEugL8OaPkPWbDHrKB31O6P0H4BD+SKQVtESq95sic79vGY3DnXzXu0Thk/cb79MXHj8N0YrVw8MictdC7nk691PtN2vtbutx3xM8kYMUm7GmIl4G7pTpLj3wcBTfCz2sCie7tWVbbaqVfJ1LUQ3nxIzcCKVt22vmn9jROvAdxGjLPriAwnFACuSXkIwQiXbcAH9RKnE7raH3TMTLFdAV3IIq0A87PKxXAWC0Jo78zmFy45fttvjp4ZhyFarO0yau26pULQkSibwca3jENrgsBoHslmkNpLK9ifNv67Fo4B3fHHH6bxC49tLFwDqHa4M9AwfkNWneCdu8hLhcl/gLCht9nmGwiiuLMIjBOuhOsAEyG0kSq2PTOQkwf6v2Akw0flmT9lymO+yuMNGj8mI9c1lJRbv3DNtsoZgdgRk0EXT+enyexrKrza7hDfY+LtwMiDTkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(6512007)(6506007)(26005)(53546011)(31686004)(186003)(8936002)(2616005)(66946007)(8676002)(2906002)(316002)(4744005)(41300700001)(83380400001)(36916002)(6666004)(36756003)(66476007)(7416002)(478600001)(38100700002)(4326008)(6916009)(86362001)(66556008)(5660300002)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkFjUGwwNjhYRUZMUVhIZVVHZVFoWk5KTmtEYk0wbXhNTEQrV2tQWWxVZzhi?=
 =?utf-8?B?b2dEWW9ZYmFaRlZRckNPZ2ZpSWVZNGdVeEMxNGlFWmRSTlRMU3BnSUFtQ1gy?=
 =?utf-8?B?Y0FrcjhkRXNKYWtrSjI4MWM2UmhiblNKUGJmYXp0ZEJ2TG1tTjJydnd3SDVm?=
 =?utf-8?B?MGdxREE2QmFVbjJGMzBESWYwaGsrczNOOE9WL1ZSYUVTa3VabVgxYUM5V1o4?=
 =?utf-8?B?QnJleUJscHlQQW1PVlVVNUc0dm9qb3htbktoM2pmOUsySDQ2aW9oQ21JTGQw?=
 =?utf-8?B?aW1OQzcwRXpxYjRUbk1jTHNzSkhTMnlVeWFNajJNLzlWSks0cUlvK0lra3JQ?=
 =?utf-8?B?R3BOSjFFdUdoZXlNVnhNK3ptMWJVS0pXUDhSZkFpZlNnQlpLRmJnTnNkZElh?=
 =?utf-8?B?ZDlSZCtFVm5LN1c2R3I3YWtKQ0RsNTRSY0szRWhweWlGV1N4aDRjYlFKdFBk?=
 =?utf-8?B?djZLTTAyZEhma1ZzMTlNR3ZTcUhDdDdHdlBwUXdzTHl1L3hLRE5TS2kzRTdL?=
 =?utf-8?B?K0ltcFVwbW9Fd1BJbjB3dnp6S0FuQ1h0VUkxdHpaNlMwSVU5diswK1dkRTJv?=
 =?utf-8?B?K0xtSEtCenZ1dmE5OVV4MjFFQnBpc0VWMVJ4SkZ3RE1MUERRY2dQenI5TVpj?=
 =?utf-8?B?aysyTzNvVkNKOEpDZ3lpako0Vk9sbGdHYTlSbyt5bFNwTEZPWjJjZmZhNmtX?=
 =?utf-8?B?RGFqUkdCQ0pQaXh1RHFsOEg2ZXZzS1ZFWDlRNk5HYXI5UGx6MithNVM1Mm41?=
 =?utf-8?B?cGp0MG9sUVNkY0dablNDWDUzejFWRFJVUWI2bXBPZlVTckV6aEE0Q0RGMUtz?=
 =?utf-8?B?MndYT0FEb2NObThNWi9OdUljZXJGNFEyUHJYU1hDS2VvSE93WWdEUXZSdHNj?=
 =?utf-8?B?eCtva2RKcEJBeDJraW9tdCt6TXlVT2E1Snd6TDVrNVFFcVNURjlzY2Y4Tk1w?=
 =?utf-8?B?Q1hTcmViMFI4NjN5WWZhZHM0LzY1T3djelkraGFYY013SVBTTEpNdlhUcXhT?=
 =?utf-8?B?cVdRaFNPSW5IOEprZ3J5eDRCblpqcmNDQitCYjE0NlhPdkFkSWY2R3hKZUk1?=
 =?utf-8?B?RFBIQlJ5SU5ZK1JqM1I2cHVOZlNjT2x5Y28yMzBuNnEvMTA5ZjhLclJEYVZl?=
 =?utf-8?B?MjZXREtOQnIwYkdlSjBDSnpWbkhYVjVlMU54L2M0aGhYTC9zdkZHa1o1eGYz?=
 =?utf-8?B?VEdnSDQxck5qUWNsTmo5SjZzVFRtb2NrRXNNZitwRXN5NDFUSU96WHlEdnZ1?=
 =?utf-8?B?YlZNbjg2R0UxNDEzYWRsOEVNYVk5ejQxdDlzaml2ZGtOcTVPNlE0V2tsUUFV?=
 =?utf-8?B?K2paWnZwdDJidjJ0UW9RMkJIbis2QXJLWGZQWWFsUzhXQi9mZTgvT1JseG1T?=
 =?utf-8?B?RnVQYkhwcmhnRUs5Q2p6Vy9GcWpXbUhCZEMwOFUxVlZrOXJBR2gzd0ZidVRv?=
 =?utf-8?B?UitacFVKaENHNlQ0dC9SQm5XZENyUW5MRkNaQmdUTWZMdkhINkdYREJNaURs?=
 =?utf-8?B?WThONDRqMUZrY0Z5MEI2RWV6WGIwNk5VeDJoNzYxTGh1TWtqUzUzWlY5bGdT?=
 =?utf-8?B?MWZ1Nm12YVdjZEZ2WDhIK0VyVzh3N2FoUmF5L1B2eisvWjJhY2dUb3lsSlo1?=
 =?utf-8?B?NXlaMFE4SGszUElNOE9qbEFDNi9rZEhNamcwVnl2bmJhS2J0eTZUa1dGUmpk?=
 =?utf-8?B?azZ1cmlwSCthMlhVTlNsYUtuc1BkWHZtYVFES2xIdHBoR1FCVWpXVk1WeWhr?=
 =?utf-8?B?WkVVTVN5NzlHR3pEeHdvMStRMnBNeXhwL1ZQTE9rNHZzRGxESjRsTGwzbG9P?=
 =?utf-8?B?ZHpXWmJuM3JwbCs0WDdRRDZidGpnS3NXWHIxaHZRLzA5NFBHdVU2bUJxZUVP?=
 =?utf-8?B?c1hWWll1d2F3S3hGU3NvV09Ma05vOFllVXJBVXg1UmlSRzFVVEkxeGs3RUxW?=
 =?utf-8?B?TTE0cHg2Z3U2SlFPTXAzdDY5SSs0eVd0U2JYR0RqZDdTTkpRTXZpMVJBV3kw?=
 =?utf-8?B?ZjdSbTB2UTE3elQ4VDJvU2V5WVZNSUM4MlU1RUlHWGNsU3FUS3g1S0pDamVo?=
 =?utf-8?B?bmplUWt5d3kzV2FROGtKUjJMdHpYWDVDUzZrNFk1d0J5eXQ2Z2ltRU5IK3JI?=
 =?utf-8?B?cXpxQlN3MVpwbWxHV3I3eXBXc0RXemhkRW5SZ0RjZXE2Y0RvTHVaWm1OTUo3?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WGhSTXFvendCNnpsc1BEaCt6a3BwWDkzZTk0N3FrbDNxMld2Q3ZXb2tIM1hv?=
 =?utf-8?B?TnhPUnRQTHJMSGM5by9yYm90NXd0UlR5aXBCcmlBd3Z2VFQ5bXM2bmE4eSsy?=
 =?utf-8?B?R2xRQ3RlTEpUM3J1MEpFNnJLSUs3RWQ5UFlIdHRWN2cwNGpQS2NOYlcyWDNa?=
 =?utf-8?B?RHRhcUM1bllObW1mK085WXowcC9sVVVCYlYrZEhXVmhhMU1SSHk3THRrQzlD?=
 =?utf-8?B?TzJyU2NwM1BzcmNBRURnRnd6Um9CR1FYRHg4alhwRlAyZ1hHSnBvY3FDSXpj?=
 =?utf-8?B?bnRJSFhtbTR2Q1RVMlpFdFVrbXlwa21rRVhjcGhzWVdvYUo1MUM5Mitpa3RJ?=
 =?utf-8?B?UGpiVnBRb1BYd2tWcys0MzBhWFRlMEVFN3lyS3MrUmdCWm95L3Z4cXd3R294?=
 =?utf-8?B?SnR2cFRFTHhQNkk3d3JDQzArb1VmZjUzaWdwcXhLb0xGaXRGQ251YlByb3pk?=
 =?utf-8?B?TG1GcTl3MGE2TjBzYmJSK1BpZmVUUStQMHB5NGp1ZXVPanBVR0REck5pSGt5?=
 =?utf-8?B?MkNSV0t1enlzS3J4MnVnQUEwR3JjN3RNNlZ1TnNiNGRGNmU0bStKT25VbHlh?=
 =?utf-8?B?ZS8xVTZVY2RwaFdRYjJiU2tCN1dIL2g2d1g1enZPenkrc2pDWXR3MUx6RXhB?=
 =?utf-8?B?c0FvZjFqazR4MVBQVHA3cG42VGIvL0pWRWY4WDNEOEtiSUdtdXl2MzIwaEY2?=
 =?utf-8?B?bk9CYmhZcURBRGpQZk5GKzFaN1FaN0xhWWpzYzllWXdyMk9xUzBYaUcrUjI1?=
 =?utf-8?B?dnYyQ2cwbjZCRjVQMEU0b1RNZFN0OHpFMy9sMWNyU1VFbFBvVHJlQzE1eXNR?=
 =?utf-8?B?RnZ4Tno4UzF4VE5lT3ZUTkZUbzRGamx1NjM3bFhIMTdBTXFiYXRORzU1QUJx?=
 =?utf-8?B?Um5VdkxHNlpVcjlhTlJCR0o4Y05XQ3dYUXBIL0lWZDBhbHBhRkRsMXlsVkhV?=
 =?utf-8?B?MHkvcTJhamVyem5aam9UZFBlUEFCMWJSQnFFVzJ1Z2NDaUJvSHpXQ0hhZnhB?=
 =?utf-8?B?WnRXd2lDMThBOWZGTkNLQkY5NEZYZGFHdysvanVxWm1lOCt0TVhsUHJPZWZn?=
 =?utf-8?B?Q3MzNDIzNG1YV3YyOVpvNi9sa1BobXdtZzdwTGxnZm9iVlVxQTFOV1BZVUl4?=
 =?utf-8?B?emN1RncrR08vUHNZUnBhVHpNUnlsT2FpT1c1YWYvSU5tdnIzbVJORTM1ZUZq?=
 =?utf-8?B?VmVNMDZNY2RrSUZ6VGdlcm43Z01NUDZ3bFVKU3BDRXhXNk9VM3QzdFZSNGdW?=
 =?utf-8?B?WG9KWHdtelFvMExYVExFaFl6QmhOQWtzdWNnMXpBTUk4VmxoUjdPTUU0blJp?=
 =?utf-8?B?blJqUGhBeTg2RDZGRjBXdFQ0NHNkenAxQUhOaHBSeGJ4SU14dTloV21pUTI5?=
 =?utf-8?B?MEw5WmN3azR2cUN0ZlVsWmZ4c0tweFNIMlZGNHlGdXdUYk1oRGxkSUx6S2t4?=
 =?utf-8?B?QWh4T2RROTl3MEZOY0w3bU1aam9IRHlmbjRNUENHNWpZWTV4NmxyY3pXZkhx?=
 =?utf-8?Q?pNOStm39ygLSt+3jmbNIs0jz+OP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83f1fea-2c06-48be-9963-08db4c78fb68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:24:30.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vp5wsycC1XIEHYTbnUEWkJd5zz6oMcAwbYI+GeFE9AfG2UZgmNLYXKwHpO1a+cChdo6NE3p1bzo6Mnmq9VjWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_04,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040068
X-Proofpoint-GUID: KvCQJ5SzrDHVh5NlrSjaswxsI7w26JC_
X-Proofpoint-ORIG-GUID: KvCQJ5SzrDHVh5NlrSjaswxsI7w26JC_
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/05/2023 19:53, Keith Busch wrote:
> On Wed, May 03, 2023 at 06:38:11PM +0000, John Garry wrote:
>> +	unsigned int size = (atomic_write_max_segments - 1) *
>> +				(PAGE_SIZE / SECTOR_SIZE);
> Maybe use PAGE_SECTORS instead of recalculating it.

ok, that simplifies it a bit, but I still do have a doubt that the calc 
I use for guaranteed amount of data which can fit in a bio without ever 
requiring splitting to queue limits is correct...

Thanks,
John
