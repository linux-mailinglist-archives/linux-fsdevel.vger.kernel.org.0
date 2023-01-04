Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C574C65CF41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbjADJLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 04:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbjADJLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:11:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE7129;
        Wed,  4 Jan 2023 01:11:22 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3047n1X8019356;
        Wed, 4 Jan 2023 09:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=22nGDurwued9N6a9PjFsYJH7fBVw6Iv7LvN2tGsfpnM=;
 b=0+TT51R6TKckHNB5ODw1TdcBRkCvabP35x+1F0iNftlRVpTZdqgtNTXPjkT5kPSLW7qu
 BP6E9MTJpTEUm7GW07qZT3pg/cyjzvrGlnTuVoJZ5cB5hIJpmMtl637wTuXm69eh3079
 R5eViZJ7gC/A+MAhE/VZjxkDixw3h6Xm9pQfWDQ/LkUkJLPQIopB0JA5VQ7ZuEfduIJi
 7l41khAGqG132ko5T9nbboY7ZQaAAWwZdmxY91GLsIAE4pSvNJUo3UZ0wVMkkwpN8uPg
 fWGU+FGCaWbBe0hL4oKKuKLR2KNGXKzh8offuKVj3HZeSuPhN7spoYohsN67wQRH232j sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0ap19a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 09:11:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3048nCPI030392;
        Wed, 4 Jan 2023 09:11:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mw69drsr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 09:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijUMc5v8U5S/3EM08RXkxDud1AxTyVIpcQU8hTMUk4r57aUlQZpy9gTr/ekj8LNUCQjM6tDi5Yx69fctu+KHFCLxp0RceDiyrHnusVwoNXc1PJGKOofQrFo2n6rkK7MMqiBcdGTcEloDsRdUMixyjTOLMnL8EJuRdc1RJbU66deyjN1Ux3/P8pf/ZYPPbLWQAlWGm6LgTIBjMpAsj/GggUzXluKOdCaxnqpAJv8w5tDEMUUGNhOR7F7nf8aFTWbqhX8ELLPDeiHsAmG5QVmpBjKYe8F8y5gbeJ95LPurIRuMkjKMEIOtOQ46kXo0//OefCOYL7Doyo0E54ynaFIOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22nGDurwued9N6a9PjFsYJH7fBVw6Iv7LvN2tGsfpnM=;
 b=JoczNvq30uNQuH1kxiBRysvwyEH8e+bDB7YIM/tgpI0EiImqr42qmYHUgc+mYsM6cOGz86GUNAv3wBuTajbtzCZPjHW8DYwJKGmC/qOWKdLS9rXweHr3IHomvqMX+4lOi0EpwyI+C0q3t7eHcpgGRHbtkeqh9j+QFNdkVdSem7/rzBuAnc7+P0oNwO/WO/MC9FVsEer+qDWia97ugpKoEWhcT9BUEzQm9lNWs9CmQQj+bkjs4pjvSAEk6SyCnm/F3Oj1Fs5ARI9YB5/i5GtNV6wUgzOUiQl3fuDokzdXtEqG8tWM6hBTghXvo5JnvXPrx+/HFciQyJzvhdF+Al5S7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22nGDurwued9N6a9PjFsYJH7fBVw6Iv7LvN2tGsfpnM=;
 b=UmxBou0ooI+37al5S/9ZYZsTyt8Y+2p6eqRpvGX3MB+6Kk/K/SXCMLXy87iULKUhyKf8HqtGAd/U6m/VTf2LSSRKW+firsnq3W6EzqKtlSNBtFCFVpdpi5e8Hnpd/v92coVO7Vy8fZxUr6HdymHnqFtdyQdmgf8pZRyqSmLfdQQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 09:11:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::8b38:e682:1a6c:7b66]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::8b38:e682:1a6c:7b66%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:11:12 +0000
Message-ID: <2e80a45e-f398-1c48-a5be-72085cd984e0@oracle.com>
Date:   Wed, 4 Jan 2023 20:11:05 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH 4/5] kernfs: Replace per-fs rwsem with hashed
 rwsems.
From:   Imran Khan <imran.f.khan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
 <20220810111017.2267160-5-imran.f.khan@oracle.com>
 <YvwdShstDCK+uQ+R@slm.duckdns.org>
 <74969b22-e0b6-30bd-a1f0-132f4b8485cf@oracle.com>
Content-Language: en-US
In-Reply-To: <74969b22-e0b6-30bd-a1f0-132f4b8485cf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0057.ausprd01.prod.outlook.com
 (2603:10c6:10:2::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 8360f033-1c53-4153-8334-08daee33a034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOY6I2voh6qEXfyNzTQW/GyuP68zk4WEn4HUeiyPSe7u4HIJ6yJnYGFewPMAm7FHfD/QulFsufkq+nGV4Szw8yayg9mRvEGTHBiGKi3960L2w0ajLjCwy4u0GaNymM5yWZRw4gM+gfODd2CwvPYCUXnDqWQVdmxllI4zaUnPrfPlt3xfKnPT8VYVibgqA/7JH7k+62PANCi+0Al9/s5ipgJ0Po/tClzgpW4oCINgBKV9440G/LKBMNZXbijJfn0D7Brk68ercA0h2l8uSNCNLq895oM9ncq1tTu17KFDpECsQJQ1WEZuuxblktrMJmIlCfCmRPPy6LGCd8rv2w1MUo8T1EWsi9tZYMuB8XRlAHKrklR8HRKfIvWCqDtLASc6YvS3xE224a5xOVpKTCsQvNKU/KraRYTsfumoez9hOj1TedDRFrcdIFNwGE4BlTCQAQdRuAyknAETVBi63IZ1/70d2Cl8hgMzl6DKy7zNUWNa47aUOVoj3XvIPpW7y+YmrMT/VLsBrbIpw0qmA2XtGdMl8EIJBQAHvFlkj8J0GaD1f3WTzykIySgpa3gIJf7S5wZyql2U321qw4ba9hxadGA5/jMaa/8akmW2MXUh2g52AT6r79jtZGGKK6WnvBfhlr6dGo1fuWPGavQHAFmwo8h5miNrVvKqNekEsguY9p+NKGIRFeeUUQC5iCaSJrh7OgKtqhCWrdTanOLszVLi6ZjsxZ/T6KYVppN+d9UKvEvWnzMh/Oc9hTS0a4Jd7eec
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199015)(316002)(2616005)(26005)(478600001)(186003)(31696002)(966005)(6486002)(6512007)(36756003)(6506007)(86362001)(5660300002)(53546011)(6916009)(2906002)(83380400001)(41300700001)(66899015)(8936002)(31686004)(30864003)(6666004)(38100700002)(4326008)(8676002)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0t0TEg1YXdiZlowNmREeFZDVTU0eXk0OStRbFVheXNlaFJUME1PeGNzeEdW?=
 =?utf-8?B?L1U0UlU3T0pEZVFCNml1bDhUQ09NWEoydXYxTktvWVVpM1Q3V0p4dmZzdEtu?=
 =?utf-8?B?b2ZZUmpFbStmR3Y0NUs4TUJBV0hoM2l3a3NVL3U4SHB6RjFjYmxUUHM3elhO?=
 =?utf-8?B?NzE2Y3VlQTVVMkVjVlhXSEI2cm81WWlXeTVSN0Z1OW4zYkJwS2tFQVhtajkw?=
 =?utf-8?B?cURObzJHTXFlb2NsejJiOGdDQXVpbEZ4WHJxbHpPNFk0RW5mbVg4c3Z2ck5a?=
 =?utf-8?B?cXdTWkY4U3BFeC9QNThMRFJmU3dMZjM3QUxmdytFNlhMWU5kMGk1Y2d5UlRw?=
 =?utf-8?B?NGJFZkpQVG9lYTMyUHRDTDVaS3J1NDE4cmRFWlVCdWsydmVVVmkwV1Q0dVhr?=
 =?utf-8?B?ZXk2eDdyYStSamcxVUFpOGI1M2YwWjZLRC9icFhsbUh3VUJORHNPNk9wZyta?=
 =?utf-8?B?Q2RMMXcyb0t4M1RVS2FvSXdhNUV3YlVVa2VmbERrRGlrcjVHVGxKQkNzaWRa?=
 =?utf-8?B?TFZFRkZzWXo2UjZCRlI1R1QvTmo5T0U4YkxOaTJOckJUR1VlME5JemJBeG43?=
 =?utf-8?B?ajF1Qk45ZlRUdzVqUDlmS0VNaGVTb2ZxNWM4bXc5OWRHUXZDbWxYUkFhODUz?=
 =?utf-8?B?enFBNHRZWFlPSzRheDdXWjBEV2h5c0VYdlpwT2ZDRTNMUEYyOUxoMjJTMmlu?=
 =?utf-8?B?NGN2YTl1MEJZZEdzdmxtODZ0Q0x0YnZUUzJBTFFFQmpOZUw3WHJCZ09sSHU5?=
 =?utf-8?B?eUZZRGFPeHovOGJ6SUJZN0lOcS9QT2tDMlJJVDA0b1VDQkhuUXRJU0JpdnM0?=
 =?utf-8?B?ai9NQmY4Q2xjWGRTZWovTUpBT3N2cWFIM3FYSll3OFBGUVZudjNKOHZoZFB4?=
 =?utf-8?B?SXNPSkxQYlVqUEZFcHROR0NzQzQ4YW83L1o4YmwxQzZ3TmZQMlJDR0FIUnJM?=
 =?utf-8?B?dHdQaHQyc3phbUJQaDFMamhjbVBRNm1vNUM3SkhqbEpVbmVNSlk3V2d3V3FQ?=
 =?utf-8?B?THdkc2hpNi9vczc0OFZlUjY4eHJrb25rejNhMjZsWEFkVmVWblA3NFowYVhC?=
 =?utf-8?B?enVtNnFlS1FFS3ZtSHF4S2dZclcxOVVuQzBTSS8wV1VmeWpGU1Z2a1N5Vlll?=
 =?utf-8?B?cmhRdFQxSmluSS90YndSK3BFL2Z3Rkl0TVVwbDRhOTdmWXI5eGgvdFRxNjgw?=
 =?utf-8?B?VWp1ZFJjRUd6Ui8rTUEwa3ZJUjUyUmdGd1hrY2ZtTExmdVh4YU5KSGtQRnhK?=
 =?utf-8?B?WHhNdS9makliRWNRK2tRRGRCekZVakJYaWxqcHFwSWw5TUlXUm5jSVZQL2tr?=
 =?utf-8?B?bVMzbG9IeVdDSTRWWEtCaGVsaExCekhCT3o4ZlJHVjdkNC9KbFA3WXNLRTRS?=
 =?utf-8?B?K3VETXBERnhwL254UDZaUU5QNTJUWDg1dS9zUENsQ2RlMlEwbzVwRFd1Z1dY?=
 =?utf-8?B?Z2M1ckJld1I2aHV2U1VMQWZDTGY5R045WnZpeXo4UzZxdlc2WGhkbnJrUzQ3?=
 =?utf-8?B?M0doM2djaUdRbjJ5bDBJdDJZTDhUamxwUk9UMzdxQ0h5OHk3NjVvUGFTLzZD?=
 =?utf-8?B?MEwwa0E3NndPZmJXTTE5QlFVeEZraVJ0Yyt3TUZkOFZQbHBMbDBML0VYdE8v?=
 =?utf-8?B?bzhQc3ZDeE1SV1poYjM5QjM5aTNIVGNaR2IyUmJjenlycUoxVll5V3RCajFT?=
 =?utf-8?B?V1NLaU1tb1FyV2E5Y2ZldkNBMHBucnFWeGhya2JwRUNDbnpGZGRuTWtiVXB0?=
 =?utf-8?B?cWppYnY5ajQzTG5xeXF5MzkvcmkzRS9FMS96ck5mNEc4a2JzY3lKdFlvbVhv?=
 =?utf-8?B?NDh5VVZ1RGxQSFkvOGtIaDFDUFhwa1lZUEhjRjRjckNzSUUySnRjekcyY3N0?=
 =?utf-8?B?Z1ozQU9JR0tReTF2YVFyaGtJaXdaa0NQcVl5ZXRNUEVGMzVmTTE3b2JEcGhk?=
 =?utf-8?B?OERBS1hxT3dGbmREOGlXWmZPeTk0VDlmNTJ0QjVkYzMyQkNhTmdqZzk2KzVs?=
 =?utf-8?B?K3Q4UzVrVDZUcHF4Mnhma2NQSE8xWG5vSW5IUS9aOVplUUNwWFVTN09IcUlp?=
 =?utf-8?B?QTNEVzBCWkdWTC8yWGVwUEI3TzYrZDl5d1FTL0F5QzF5Z3QxN2JraktKSG1S?=
 =?utf-8?B?anRGaUxNUGpUd2Z3ckJiclViMjVPTzlrWUE2RVBWK2tCemY4eGJBVjRxWVpV?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTN2Q1JXQzdLMGsxcU13TytWZUdqUmMySE5uV2hMampKRHZYVUp6K0hCSEJI?=
 =?utf-8?B?SThqVS9NdE5DTy9mRFJMSXlqd3VOU3daT1pxNE5CQ2RBWU9PMnRvcUZIVUlt?=
 =?utf-8?B?dFMxSkxrdTdvQ3prSmhYemVBcEpMZzd2ZXc1ODdua3REejcybmNDODNENnJF?=
 =?utf-8?B?VmFZYjJ2eVIzYW5hWHVHL2FPNVVtY3V1OVZ0WjNTei8rNjZTSUhlMlpjYkdD?=
 =?utf-8?B?RlRXKzgyK0hCSTVoNlJUNWNqTkR0NEN3ekVxMDM1cEJObEp5cURQdjNXU0NH?=
 =?utf-8?B?K2NHSzdvaXA2L3V3ZklpbUVBSGZGWEo2LzFCT1M0MmsyLzVadlZxd3Z6WUVI?=
 =?utf-8?B?ellTZWJLc1JRODluRnEreTZjMUdjcW00UVo3S0gxZC91Q1JaN0xxUmgyWDRH?=
 =?utf-8?B?NXZrMklXdTVxNFdWbnNuME11dVQvK3dwTFNZZjNXQTgydDVhY2VMYlJkd3hV?=
 =?utf-8?B?bkZ6UHMwL2xGU1IyejdrVjgrZk1nTWdDam41UHRDWHRlb2dpR0hSN05yYzFh?=
 =?utf-8?B?ays4bUFZQWVGYlIxL2xxM2FvS05GTUQ0b01GUlN3Wnk4cHJETWpCWEtzZk9u?=
 =?utf-8?B?czZoVmFpbHd6bHVIaUtoNG9wVzI4ZG9WNUtndElUeDB3SjJqcjVPemRmNkg5?=
 =?utf-8?B?RjFISGd0eENPZ2xXaklwTXFPaDYwVjZDWnFSWC8zTWNWdW9hNHZST0JGOE5w?=
 =?utf-8?B?dk4rWGZIUklLeGZZZVo4Vndqc2JPZ1lsNEZOWUhxRkFjZXQzdWRuenZYNnRk?=
 =?utf-8?B?RG1FS0YzbUl5Z3pGMFVQTDlFbVR1aDE0MGsweUlRemF1d1hlZjZJamZvMDRm?=
 =?utf-8?B?KyswOWR4eURua2ZIRW4rZ1dlYmFLdUtoTDQyMTZnTGo3bWh6aFY4aUpTb085?=
 =?utf-8?B?U0IyMkdGU0ZwT1pZeEJXTXVXNGRyWXR1Ynp4dEltbG9rQ2xtbVV4ODBMRkJx?=
 =?utf-8?B?eGVwVCtzMW4rQ0JxelRMamlwNVZjdWR2eVZTU2V2Mi9xU3RqZUZ5blVOQjJZ?=
 =?utf-8?B?amk2VWliTGM5cFAzTmJYZVU4djBXa3RsSGxub3JUKzF4SHpVQ2pnNk40ckdz?=
 =?utf-8?B?VEM5VTlFaFgxbzQvN0k4NFlGeEpCbXlZSmtoMzlLbE1seVFsQmpKM2FEbWFo?=
 =?utf-8?B?bWoyTzYxdDJPTFEyNWFNVDFVRG9VUjBsRDI2VUc2c2FxNFVRb1dNQW9kRnRk?=
 =?utf-8?B?NnlzcmF6UGpMTlBUU2U4R093cjBlREJrZHFPcWRyRE5WRThLTXZFQmtKVmRv?=
 =?utf-8?Q?0D2O2ngzY3vhUFh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8360f033-1c53-4153-8334-08daee33a034
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:11:12.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbw0qho96miLMsqXtM9KkeHm9JRkq8VtZfLea2apB4MfMfdFjgvf4oKHZkSCf5QzCjUghxwnlZUVoXlwSHNI8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_04,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040077
X-Proofpoint-GUID: Gs5SBW1QgCNrZkOjDqHDlQNDHcoMpF6q
X-Proofpoint-ORIG-GUID: Gs5SBW1QgCNrZkOjDqHDlQNDHcoMpF6q
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Tejun

On 14/11/2022 4:30 am, Imran Khan wrote:

[...]
> 
> Below is reasoning and data for my experiments with other approaches.
> 
> Since hashed kernfs_rwsem approach has been encountering problems in addressing
> some corner cases, I am thinking if some alternative approach can be taken here
> to keep kernfs_rwsem global, but replace its usage at some places with
> alternative global/hashed rwsems.
> 
> For example from the current kernfs code we can see that most of the contention
> towards kernfs_rwsem is observed in down_read/up_read emanating from
> kernfs_iop_permission and kernfs_dop_revalidate:
> 
> 	-   39.16%    38.98%  showgids     [kernel.kallsyms]      [k] down_read
>              38.98% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 36.54% link_path_walk
>                     - 20.23% inode_permission
>                        - __inode_permission
>                           - 20.22% kernfs_iop_permission
>                                down_read
>                     - 15.06% walk_component
>                          lookup_fast
>                          d_revalidate.part.24
>                          kernfs_dop_revalidate
>                          down_read
>                     - 1.25% kernfs_iop_get_link
>                          down_read
>                  - 1.25% may_open
>                       inode_permission
>                       __inode_permission
>                       kernfs_iop_permission
>                       down_read
>                  - 1.20% lookup_fast
>                       d_revalidate.part.24
>                       kernfs_dop_revalidate
>                       down_read
> 	-   28.96%    28.83%  showgids     [kernel.kallsyms]       [k] up_read
>              28.83% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 28.42% link_path_walk
>                     - 18.09% inode_permission
>                        - __inode_permission
>                           - 18.07% kernfs_iop_permission
>                                up_read
>                     - 9.08% walk_component
>                          lookup_fast
>                        - d_revalidate.part.24
>                           - 9.08% kernfs_dop_revalidate
>                                up_read
>                     - 1.25% kernfs_iop_get_link
> 
> In the above snippet down_read/up_read of kernfs_rwsem is taking ~68% of CPU. We
> also know that cache line bouncing for kernfs_rwsem is major contributor towards
> this overhead because as per [2], changing kernfs_rwsem to a per-cpu
> kernfs_rwsem reduced this to a large extent.
> 
> Now kernfs_iop_permission is taking kernfs_rwsem to access inode attributes
> which are not accessed in kernfs_dop_revalidate (the other path contending for
> kernfs_rwsem). So if we use a separate rwsem for protecting inode attributes we
> can see that contention towards kernfs_rwsem greatly reduces. For example using
> a global rwsem (kernfs_iattr_rwsem) to protect inode attributes as per following
> patch:
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 6acd9c3d4cff..f185427131f9 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -757,11 +757,13 @@ int kernfs_add_one(struct kernfs_node *kn)
>                 goto out_unlock;
> 
>         /* Update timestamps on the parent */
> +       down_write(&root->kernfs_iattr_rwsem);
>         ps_iattr = parent->iattr;
>         if (ps_iattr) {
>                 ktime_get_real_ts64(&ps_iattr->ia_ctime);
>                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>         }
> +       up_write(&root->kernfs_iattr_rwsem);
> 
>         up_write(&root->kernfs_rwsem);
> 
> @@ -1442,10 +1444,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
>                                 pos->parent ? pos->parent->iattr : NULL;
> 
>                         /* update timestamps on the parent */
> +                       down_write(&root->kernfs_iattr_rwsem);
>                         if (ps_iattr) {
>                                 ktime_get_real_ts64(&ps_iattr->ia_ctime);
>                                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>                         }
> +                       up_write(&root->kernfs_iattr_rwsem);
> 
>                         kernfs_put(pos);
>                 }
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 74f3453f4639..1b8bffc6d2d3 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -101,9 +101,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct
> iattr *iattr)
>         int ret;
>         struct kernfs_root *root = kernfs_root(kn);
> 
> -       down_write(&root->kernfs_rwsem);
> +       down_write(&root->kernfs_iattr_rwsem);
>         ret = __kernfs_setattr(kn, iattr);
> -       up_write(&root->kernfs_rwsem);
> +       up_write(&root->kernfs_iattr_rwsem);
>         return ret;
>  }
> 
> @@ -119,7 +119,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
> struct dentry *dentry,
>                 return -EINVAL;
> 
>         root = kernfs_root(kn);
> -       down_write(&root->kernfs_rwsem);
> +       down_write(&root->kernfs_iattr_rwsem);
>         error = setattr_prepare(&init_user_ns, dentry, iattr);
>         if (error)
>                 goto out;
> @@ -132,7 +132,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
> struct dentry *dentry,
>         setattr_copy(&init_user_ns, inode, iattr);
> 
>  out:
> -       up_write(&root->kernfs_rwsem);
> +       up_write(&root->kernfs_iattr_rwsem);
>         return error;
>  }
> @@ -189,10 +189,10 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
>         struct kernfs_node *kn = inode->i_private;
>         struct kernfs_root *root = kernfs_root(kn);
> 
> -       down_read(&root->kernfs_rwsem);
> +       down_read(&root->kernfs_iattr_rwsem);
>         kernfs_refresh_inode(kn, inode);
>         generic_fillattr(&init_user_ns, inode, stat);
> -       up_read(&root->kernfs_rwsem);
> +       up_read(&root->kernfs_iattr_rwsem);
> 
>         return 0;
>  }
> 
> @@ -285,10 +285,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
>         kn = inode->i_private;
>         root = kernfs_root(kn);
> 
> -       down_read(&root->kernfs_rwsem);
> +       down_read(&root->kernfs_iattr_rwsem);
>         kernfs_refresh_inode(kn, inode);
>         ret = generic_permission(&init_user_ns, inode, mask);
> -       up_read(&root->kernfs_rwsem);
> +       up_read(&root->kernfs_iattr_rwsem);
> 
>         return ret;
>  }
> 
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index fc5821effd97..4620b74f44b0 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -47,6 +47,7 @@ struct kernfs_root {
> 
>         wait_queue_head_t       deactivate_waitq;
>         struct rw_semaphore     kernfs_rwsem;
> +       struct rw_semaphore     kernfs_iattr_rwsem;
>  };
> 
> 
> 
> greatly reduces the CPU usage seen earlier in down_read/up_read:
> 
> 
>  -   13.08%    13.02%  showgids       [kernel.kallsyms]       [k] down_read
>              13.02% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 12.18% link_path_walk
>                     - 9.44% inode_permission
>                        - __inode_permission
>                           - 9.43% kernfs_iop_permission
>                                down_read
>                     - 2.53% walk_component
>                          lookup_fast
>                          d_revalidate.part.24
>                          kernfs_dop_revalidate
>                          down_read
>                  + 0.62% may_open
>         -   13.03%    12.97%  showgids       [kernel.kallsyms]      [k] up_read
>              12.97% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 12.86% link_path_walk
>                     - 11.55% inode_permission
>                        - __inode_permission
>                           - 11.54% kernfs_iop_permission
>                                up_read
>                     - 1.06% walk_component
>                          lookup_fast
>                        - d_revalidate.part.24
>                           - 1.06% kernfs_dop_revalidate
> 
> As can be seen down_read/up_read CPU usage is ~26% (compared to ~68% of default
> case).
> 
> Further using a hashed rwsem for protecting inode attributes as per following patch:
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 6acd9c3d4cff..dfc0d2167d86 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -734,6 +734,7 @@ int kernfs_add_one(struct kernfs_node *kn)
>         struct kernfs_iattrs *ps_iattr;
>         bool has_ns;
>         int ret;
> +       struct rw_semaphore *rwsem;
> 
>         down_write(&root->kernfs_rwsem);
> 
> @@ -757,11 +758,13 @@ int kernfs_add_one(struct kernfs_node *kn)
>                 goto out_unlock;
> 
>         /* Update timestamps on the parent */
> +       rwsem = kernfs_iattr_down_write(kn);
>         ps_iattr = parent->iattr;
>         if (ps_iattr) {
>                 ktime_get_real_ts64(&ps_iattr->ia_ctime);
>                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
>         }
> +       kernfs_iattr_up_write(rwsem, kn);
> 
>         up_write(&root->kernfs_rwsem);
> 
> @@ -1443,8 +1446,10 @@ static void __kernfs_remove(struct kernfs_node *kn)
> 
>                         /* update timestamps on the parent */
>                         if (ps_iattr) {
> +                               struct rw_semaphore *rwsem =
> kernfs_iattr_down_write(pos->parent);
>                                 ktime_get_real_ts64(&ps_iattr->ia_ctime);
>                                 ps_iattr->ia_mtime = ps_iattr->ia_ctime;
> +                               kernfs_iattr_up_write(rwsem, kn);
>                         }
> 
>                         kernfs_put(pos);
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 74f3453f4639..2b3cd5a9464f 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -99,11 +99,12 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct
> iattr *iattr)
>  int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
>  {
>         int ret;
> +       struct rw_semaphore *rwsem;
>         struct kernfs_root *root = kernfs_root(kn);
> 
> -       down_write(&root->kernfs_rwsem);
> +       rwsem = kernfs_iattr_down_write(kn);
>         ret = __kernfs_setattr(kn, iattr);
> -       up_write(&root->kernfs_rwsem);
> +       kernfs_iattr_up_write(rwsem, kn);
>         return ret;
>  }
> 
> @@ -114,12 +115,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
> struct dentry *dentry,
>         struct kernfs_node *kn = inode->i_private;
>         struct kernfs_root *root;
>         int error;
> +       struct rw_semaphore *rwsem;
> 
>         if (!kn)
>                 return -EINVAL;
> 
>         root = kernfs_root(kn);
> -       down_write(&root->kernfs_rwsem);
> +       rwsem = kernfs_iattr_down_write(kn);
>         error = setattr_prepare(&init_user_ns, dentry, iattr);
>         if (error)
>                 goto out;
> @@ -132,7 +134,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
> struct dentry *dentry,
>         setattr_copy(&init_user_ns, inode, iattr);
> 
>  out:
> -       up_write(&root->kernfs_rwsem);
> +       kernfs_iattr_up_write(rwsem, kn);
>         return error;
>  }
> 
> @@ -188,11 +190,12 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
>         struct inode *inode = d_inode(path->dentry);
>         struct kernfs_node *kn = inode->i_private;
>         struct kernfs_root *root = kernfs_root(kn);
> +       struct rw_semaphore *rwsem;
> 
> -       down_read(&root->kernfs_rwsem);
> +       rwsem = kernfs_iattr_down_read(kn);
>         kernfs_refresh_inode(kn, inode);
>         generic_fillattr(&init_user_ns, inode, stat);
> -       up_read(&root->kernfs_rwsem);
> +       kernfs_iattr_up_read(rwsem, kn);
> 
>         return 0;
>  }
> @@ -278,6 +281,7 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
>         struct kernfs_node *kn;
>         struct kernfs_root *root;
>         int ret;
> +       struct rw_semaphore *rwsem;
> 
>         if (mask & MAY_NOT_BLOCK)
>                 return -ECHILD;
> @@ -285,10 +289,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
>         kn = inode->i_private;
>         root = kernfs_root(kn);
> 
> -       down_read(&root->kernfs_rwsem);
> +       rwsem = kernfs_iattr_down_read(kn);
>         kernfs_refresh_inode(kn, inode);
>         ret = generic_permission(&init_user_ns, inode, mask);
> -       up_read(&root->kernfs_rwsem);
> +       kernfs_iattr_up_read(rwsem, kn);
> 
>         return ret;
>  }
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index fc5821effd97..bd1ecd126395 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -169,4 +169,53 @@ extern const struct inode_operations kernfs_symlink_iops;
>   * kernfs locks
>   */
>  extern struct kernfs_global_locks *kernfs_locks;
> +
> +static inline struct rw_semaphore *kernfs_iattr_rwsem_ptr(struct kernfs_node *kn)
> +{
> +       int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +       return &kernfs_locks->iattr_rwsem[idx];
> +}
> +
> +static inline struct rw_semaphore *kernfs_iattr_down_write(struct kernfs_node *kn)
> +{
> +       struct rw_semaphore *rwsem;
> +
> +       kernfs_get(kn);
> +
> +       rwsem = kernfs_iattr_rwsem_ptr(kn);
> +
> +       down_write(rwsem);
> +
> +       return rwsem;
> +}
> +
> +static inline void kernfs_iattr_up_write(struct rw_semaphore *rwsem,
> +                                        struct kernfs_node *kn)
> +{
> +       up_write(rwsem);
> +
> +       kernfs_put(kn);
> +}
> +
> +
> +static inline struct rw_semaphore *kernfs_iattr_down_read(struct kernfs_node *kn)
> +{
> +       struct rw_semaphore *rwsem;
> +
> +       kernfs_get(kn);
> +
> +       rwsem = kernfs_iattr_rwsem_ptr(kn);
> +
> +       down_read(rwsem);
> +
> +       return rwsem;
> +}
> +
> +static inline void kernfs_iattr_up_read(struct rw_semaphore *rwsem,
> +                                       struct kernfs_node *kn)
> +{
> +       up_read(rwsem);
> +
> +       kernfs_put(kn);
> +}
>  #endif /* __KERNFS_INTERNAL_H */
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index d0859f72d2d6..f282e5d65d04 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -392,8 +392,10 @@ static void __init kernfs_mutex_init(void)
>  {
>         int count;
> 
> -       for (count = 0; count < NR_KERNFS_LOCKS; count++)
> +       for (count = 0; count < NR_KERNFS_LOCKS; count++) {
>                 mutex_init(&kernfs_locks->open_file_mutex[count]);
> +               init_rwsem(&kernfs_locks->iattr_rwsem[count]);
> +       }
>  }
> 
>  static void __init kernfs_lock_init(void)
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 73f5c120def8..fcbf5e7c921c 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -89,6 +89,7 @@ struct kernfs_iattrs;
>   */
>  struct kernfs_global_locks {
>         struct mutex open_file_mutex[NR_KERNFS_LOCKS];
> +       struct rw_semaphore iattr_rwsem[NR_KERNFS_LOCKS];
>  };
> 
>  enum kernfs_node_type {
> 
> 
> gives further improvement in CPU usage:
> 
> -    8.26%     8.22%  showgids         [kernel.kallsyms]       [k] down_read
>              8.19% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 7.59% link_path_walk
>                     - 6.66% walk_component
>                          lookup_fast
>                        - d_revalidate.part.24
>                           - 6.66% kernfs_dop_revalidate
>                                down_read
>                     - 0.71% kernfs_iop_get_link
>                          down_read
>                  - 0.58% lookup_fast
>                       d_revalidate.part.24
>                       kernfs_dop_revalidate
>                       down_read
>         -    7.44%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
>              7.39% __libc_start_main
>                 __open_nocancel
>                 entry_SYSCALL_64_after_hwframe
>                 do_syscall_64
>                 sys_open
>                 do_sys_open
>                 do_filp_open
>               - path_openat
>                  - 7.36% link_path_walk
>                     - 6.45% walk_component
>                          lookup_fast
>                          d_revalidate.part.24
>                          kernfs_dop_revalidate
>                          up_read
> 
> In above snippet CPU usage in down_read/up_read has gone down to ~16%
> 
> So do you think that rather than replacing global kernfs_rwsem with a hashed one
> , any of the above mentioned 2 patches (1. Use a global rwsem for protecting
> inode attributes or 2. Use a hashed rwsem for protecting inode attributes)
> can be used. These patches are not breaking code paths involving multiple nodes
> that currently use global kernfs_rwsem.
> With hashed kernfs_rwsem I guess there will always be a risk of some corner case
> getting missed.
> 
> If any of these approaches are acceptable, I can send the patch for review along
> with other changes of this series
> 
Could you please share your feedback about the above mentioned 2 approaches to
reduce contention around global kernfs_rwsem ? Also the first 2 patches of this
series [1] are not dealing specifically with with kernfs_rwsem, so could you
please share your feedback about those 2 as well.

Thanks,
 -- Imran

[1]: https://lore.kernel.org/lkml/20220810111017.2267160-1-imran.f.khan@oracle.com/
