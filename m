Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5A730C67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 02:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjFOAue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 20:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbjFOAua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:50:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5823626B6;
        Wed, 14 Jun 2023 17:50:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EKANU0021104;
        Thu, 15 Jun 2023 00:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NDoqouHqPO2jkvtFwk4fEPF0vsmXh31ecVEUoc+ReP8=;
 b=ZJGDnKsxmXbYJoNzm/f9xA3FXxqtkJ/lIX/WS28YPgqUeMBb5OSFLblQRMZs0viINTY+
 VSp5IV9rWd05p1EcSH1emY9FfiWxAlwPBRiazOOOlzPsYSmNdxVjESpZhnGnfd150n8t
 v2PEmViVqePeXkw236coghQuOw16reHQxlQOJTGpS4hu3cpgwjDQZKpzFmyljnKKZdta
 xzMSJqYKOXkCd4bO/Nqwv3R76Qfk8s4VrDYtO5+7kzGxw1iE0AHEeUNX/RU286GdWTbr
 TPcSEm554treyPmutbOiqVcU175HCmLdAdFMOAQj8x48DrxFJEcvCuy7e49BXQkYx3wR iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdrq4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:49:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENbOmj014058;
        Thu, 15 Jun 2023 00:49:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6100x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXLOQvraeJPWPE5Zs5q1WNxiG7ElaEEHeZnu0cIMXItp/siUfKJU9fvS8yDiwd+ZOwmmflm/SA4UOJC0QTExfqXnm0sYa7jKmW4RaSMlIzdIaKRZOYyce7ZXTR9cdJtwgPAGGYbqCAo8WasPsRJ+2o3X7fx3POq2mE3rj68f1EeLkqVuKdPKq7Ijer0iA03PyTsqkvW8ROPwuLq+EngN0dn/O2k43g2VLcWfs2NTCUJxK9mwWLiBScQDUVQyMczanwb6xt4AWgAOWkx0SNXmCCMf6CcggueFnjAmaUMgtjDOe83NEIsgT4JDhZ6LKIEDjwGds5NsB5MKMKSLWExX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDoqouHqPO2jkvtFwk4fEPF0vsmXh31ecVEUoc+ReP8=;
 b=Fudmgp06lkT8LNjv7VaZPtkt2rQPOXh/jmtPkb7ErfdJ2rxQKEuV0+llsWo/9yXmbPyTjMRCJcW3ZW6pBqqR6DwAotmJEq0mxxoLHhdZu8+wg6VasVHXB0NFOL8dfzBTZHV1aWE/Vl7bUsclcMyFMqPLTYw6K0+eSppZ089In31+PcMb0qjwWRFlYjoxydHFN/6AlyvFUnyb8hEBfNaslcJNSo0HjUfeuyVQAKh27R85dJ6hKqXbRsBWReHbm3dHvaBWnEQRiskB+uE0P1uJ/SciDdU5Y/tgdlhC46CNHIQ1CXxpWeJa+RpbhPN1JZ4VsRADTgzGhoubQCsoZDzwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDoqouHqPO2jkvtFwk4fEPF0vsmXh31ecVEUoc+ReP8=;
 b=AWIwtLKcMJY+3yE4HlY0xRtarOA3SvxHQbvAanJbkcGRxhYZ1Fa2skh/BMo0nZaSu3ou9WyCy34YxFipssbhADY9Jqp2xvnpL4umuAiD7nukdMxj/P21XNhnNnw6Lr4jz6Rd6o7jukVE2AP5v149Dg7v+AEzalazxk+QN0S25+s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7584.namprd10.prod.outlook.com (2603:10b6:a03:547::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 00:49:56 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 00:49:56 +0000
Message-ID: <80bea2b0-db8a-0441-e7c4-051898729101@oracle.com>
Date:   Wed, 14 Jun 2023 17:49:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230509054714.1746956-1-jane.chu@oracle.com>
 <20230509054714.1746956-2-jane.chu@oracle.com>
 <6482999b3afd8_142af82946e@dwillia2-xfh.jf.intel.com.notmuch>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <6482999b3afd8_142af82946e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::11) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: e4aff755-d635-46e6-8c72-08db6d3a702f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGXih7eWon7GBS8JPKBxqpFBJDXG81vKIy4bSzLDpJ8uqqyOjvWVAgqWEpoJfYJtvRwVOdgckthUbjtprXbhze+b2qOJKF6m6Xi9gQKcixAPM2Pq9U19XE9dww9ZyKaR760Gn332dI32ZhQGPklfs9hdgkwxGegrTeZkOf2Xar2ayuyQymd30oN1hHKi4P5xDKDxdd48rtFyGkPKDZna0UtXAvgYLLt2h18tVyzFTnJtNAPj8v4SXbPcIDSkJJvLAR7RV32RNmB1kkzyrQsElUi0YZrh/2pLJlrGzAMYL2/V/oJAT48SphJSj2bazwc6M+mrbeS7PBY8t76VGdh+UKVGdqnlc3G3FGAFnt8vDTcy0eBDoGrdzjnn1HyBtx0tSeriBAygqmZyd7Mjcj8FyH4UxhB0QF43GOgbgbm4a/qZZS3pX60KYVndXeZYPsMNtIublboam7H3xaM8bhskfOp+DNk4OpE/7reV9LFY2fjuFzmQZBf+R1eKLK62SbVhnf3XAh4iy9L8Vgi6CCAOyb22gMSQUqd3tDIlIHlKg5QmilpXRbZw6j97T6n+7gArYNqUvtyV1hyDnL4lCpubArhE+QLbGZZbmdWX80kSJljxKWo5zwcuy5N+GqlfK/HC4StriQWJryJ15l92TR39kpwwyc06MO24z3piiEBqtkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(86362001)(31696002)(36756003)(4744005)(2906002)(6512007)(6506007)(44832011)(7416002)(53546011)(66946007)(26005)(5660300002)(478600001)(8676002)(31686004)(8936002)(6486002)(2616005)(316002)(41300700001)(66476007)(6666004)(66556008)(38100700002)(186003)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVBc1orb0VSaGxPcm4yL2RXSXFIZkk0THN4Y0xOVXIxODcxSFMrTE9UbEI5?=
 =?utf-8?B?WFpNY3NwZXluelFVUVF5Z2FaeGJQODl1VGlSaGxtNXlrU3lDelZTWU5TZ2dZ?=
 =?utf-8?B?dmhWVFdlL3FST2w5MU8vaStrODllSXdkM3dEczJkWGI2SCs4Y2QvMC9YbE5S?=
 =?utf-8?B?TVlkOEtSdmF4UWFvRWJ1NkVxRVpacE1aZnc1UCtkTXlLZjRKeC9acStNaWVU?=
 =?utf-8?B?NlZzb0cxazdvbFVFQW12VDNyQVdDRHBEZzAyRmZWYzk0NmtzVWIyMlozbDJN?=
 =?utf-8?B?SWVETUNEV2xIcUdaM0U0QmFOTFppeTZrUFprWE5IZUVpN1I3bGZOUnhJOUhT?=
 =?utf-8?B?dXlCT1g5TmpvQWdXczFOZ2FmTEJRNGVXMGU3OTdjazlFdEltNWFNWUdiTGg4?=
 =?utf-8?B?SUNsRFlhS2JtNCtaVmVsUnpXTUVSR2h1SnZjei9nbDBpVFNmckwvVmNDZWdU?=
 =?utf-8?B?ZlhtRUpvUm40cHkwL1RsU0RnZHZaWjhjd2k3Tis5L2R3eGtMdlNoMWhlYU83?=
 =?utf-8?B?eTJhRGhsWDV6RFNTYjM4RlR5MWV1MGpZTzd2dVQ3UTVjTVhnWEFpSzlVaG9X?=
 =?utf-8?B?VXJuSmFXeXppVkpJQ3plNjV2YTFzenlFRDFkL3pMZlp4TDVwdHpuNmJidUJX?=
 =?utf-8?B?M0xTVUZyRkRaSmtOSm5jRnNWVjNSKzlUdFRRQkNyc2tpZm5vVXJrRnlkclpO?=
 =?utf-8?B?Y2cydVk2L0JiN1VnU25aNTlpbk1JWCt5ZGtCT05pT2NsZ2h4a0IxendQUlNG?=
 =?utf-8?B?YzgyUEluL1hOSTZ0WWNOS2lWNnZtZDBjTHJyWUtOVzhvRDlBVGpGamNMREFw?=
 =?utf-8?B?emdML3FoYnc0eDdWOVZ3SjdOcFcyNlFtUE9yd1BPbnB2b2hiZFI0aWo3eUNX?=
 =?utf-8?B?RTZZa0U1dWZiT05xdG1XVmhGbmxTbXU2SzRaSGhpK0poR0JFNzNzR0NGTk15?=
 =?utf-8?B?K2FsekozN0ErU0NvdENVNnFyQTZmZ1FqMEJVZkUvYytLTlVQSXF3U2VYRUJP?=
 =?utf-8?B?dERNbmVKcVBkaFdZeDBmNGxJR0hFYWhlKzJiM2NJblVveXlyT3lKYS9CVFRs?=
 =?utf-8?B?L0VReWk3RVdrdURtcDdhQlpzaDA2WERjNGZYZFRFUysvRFJLMUdDZUcwZ3ly?=
 =?utf-8?B?UDFVd3NXVnhZVkxaUFRZTHFLdm9JeDlUU0ZReTJCYnN6elhISUQ2TzhyY2VI?=
 =?utf-8?B?QWR2eDhhb1IxeWpsdWdFQ1FUYUd6K2w1OVBmbGQ4Ym9wdmhtNjBGdjFwbllD?=
 =?utf-8?B?ak9uamNScS9xZFZmOGVSTWVsRi8zQ2xNOWQvY2VrWGtRSmtidGQ3cEdrVzUz?=
 =?utf-8?B?dGs3bFE5ZUhlMjhWODE3bFlnTkVpeDFpU1lHaVNLNE5nNnZFS2JDUXc4eElD?=
 =?utf-8?B?YjBUZ2FLU2ttT2VEWkllbVRXclBCYWpLT0htUVlCT2NTM2lzU0xQeHNhU3NX?=
 =?utf-8?B?dGEyeUs3Z3FiWGRpUXk0RUszWG4xTE1rdGNIZnlOZ0xQUDRHNVBRVkRNdWIx?=
 =?utf-8?B?bHNCejROcHd4SGZpcTNRNUR5cGEybHFrcDN6Qm1LU3NiWWxqeGltMXFFMVph?=
 =?utf-8?B?dGl3NGZmRTByamZaZUhWcTd5RWhoWGp1ZDRicHkvTlVoM3ZscDNwcGFUbUZY?=
 =?utf-8?B?M3Y5NnNyVkJ4K1VtdzdsSEc0dCtXM0hoNGZjeGxkb1FpMi9kWEZxSkFKSU4v?=
 =?utf-8?B?dk5uTUM3aFJSOStsMUwvYjBONXlNb0pDMy8yQVI0R2tnbi9nRUVvbDlBYzFS?=
 =?utf-8?B?ajN6QmwvWkpSVlFhRytyM3RiNnRLZkN3V0hUaWVJQkZWVDFaUWVvMk5Zd0VY?=
 =?utf-8?B?T0tYRzE5VmJqbCsyMSs1eFpqTlZpdlhDMHR2aDBkbGpua2p6WGswSzlKZE5w?=
 =?utf-8?B?eUhUTnhYT2VJOHYyUDRpQTRVRjVqN1dkTzYrVmg0VjdIVTVDaE1FU2lhR1Bh?=
 =?utf-8?B?K2pQRndTYUVKV0o2TnRLMjhqUXpKcTFyM0xWTEdJTWFkMTljNnZnMEtueXBm?=
 =?utf-8?B?d2ppN1hsc1BrV2o4Z3RiM0N2VlBMOGdBQmx2WkYrTExHNGhwU3ZUQkxzdjcy?=
 =?utf-8?B?ZVliWDVZVjNlMnlpcC9PMlVCbnczeVczVlZzaUVMby9yeDdiNDZGTzNlWVBp?=
 =?utf-8?Q?FkhhB9atfVrc+segK/ynunJzk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eGNSczk0QWpQV1hPZHNOQjM2aVR0QW5LS1BuSFR2ejZUdzF2Zmp3Uzd6TFVQ?=
 =?utf-8?B?aHdtZUxCWCtZajVIT3JRSXFjSm0vekJ2R2NSWUkwMTZEZm96VTVLUlVOb0VR?=
 =?utf-8?B?a3JSZXdDa3lWVUpOcDh0bVRWaUd0TTZ0YncxSHlDUng1TjU1OHFselVCYTBM?=
 =?utf-8?B?MXh4bkk4M0JpTEsvQ21ZWUVMeG84UW1kOTZIWlYzTS9vc0ZTQ0dsMVZ4Sk1n?=
 =?utf-8?B?bU83QXl2VEliZFozbEl6VVluYjdubmlteFFqeDcxeDg0WUd0RmRDM2dqejlj?=
 =?utf-8?B?SmxtQzExb3dPUm0xZ0RMeHk3ZmJDT1dSQjdCQi8xSjZXSm5wQUNUbmd6SmRL?=
 =?utf-8?B?YlNGVEh3TFh0aWFjcGJXZTdCajJYQm1vWkplTmcyc2xxU0R5L1d3U0daQnFB?=
 =?utf-8?B?L1VReXJsTUpWRE40TWx4NkZlOURXK3YwSEpocUl6M24ySnRJQU9QMHpac3dE?=
 =?utf-8?B?N1d4Rm5vNUJTWkIxNVlOekhVZlh1NUZ4SFpnTURwbk1HN1VlVEtjbWlMeGxS?=
 =?utf-8?B?RDFlUmtPRHMyU1Z5OXRBK3JENzZUWlFxZUg3dnBGaWFKTXpROEs5TzVTQm5t?=
 =?utf-8?B?QXNyTVlwSDFZV3VlOXl5QjRkSlZwRCtGc1ArZkNROUJOandwVFV3WGl6QnlS?=
 =?utf-8?B?UTd1UnJqK1FNL3ZQbXJEaVhiS3lyQmU0WVFrUnVwNEltb05kY2ZpYWNlVHZh?=
 =?utf-8?B?T1hVY2VCYXZMQnZyUUJFNjQ1a0IyNWg1aHVXVmthUmUrM0UvREJOMVJ5WW1H?=
 =?utf-8?B?cmRWTGVXQ05lOGFFYTFOM3gxTEZoU2dWaXhkV01oVzBEL3UwSkdSNHpzWHBt?=
 =?utf-8?B?VmZTUXBkSkNoSjZqNkJEOHJaU25uRkd5ekp0M1g3OHQvelF1cE9KMGlkMi9V?=
 =?utf-8?B?K2l6NVBwYm9vNDV3WUp4RklGbnBLUldCckpZczdIcXg3TjZNYTFNMzlQTlhq?=
 =?utf-8?B?Y0tHSWJBMnBZb2N5Y1ZHVW8xMEMxU1lJRXRoU25ZdUNNazAvc2tLWWdFOG5k?=
 =?utf-8?B?d05CTHFCQ1pFTDdwV04vQlNXYjBWSmY5cEhKVXAyWWVISUlNaENQeDJHVzdx?=
 =?utf-8?B?UkxMbzBLckU1YmhWUUp4QXU1ZHBqZWtoTXB5TG9ReVB0RVp4Z0poQWJNVjJj?=
 =?utf-8?B?UG93bW95Z2tzNzA0WDRXb3ViaHJkOGg5cVg1R0pRQmpremZweVFLZTY5V3NS?=
 =?utf-8?B?dHVxUFZVRExQOG5JZzlYdFQzMXhlbHhPbEhneXVOV3VBRkErL3MrZWd5UVFS?=
 =?utf-8?B?c2o1dVMwTUlLTUpPcWFKZHlTMjFlM2luZGliWFBRTXRPWHRxUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4aff755-d635-46e6-8c72-08db6d3a702f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:49:56.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSlBl9j7nSULTTg3KQWWbNt4ezTH7Kjpzc5v0pQycA8StUQagS0CzgHjBHaFNvjsEwy5rVetOW9LAI2/gahIeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=920 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150005
X-Proofpoint-ORIG-GUID: nj6C591mOo1bx0DjRzordvhOm-7QhVYh
X-Proofpoint-GUID: nj6C591mOo1bx0DjRzordvhOm-7QhVYh
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/8/2023 8:16 PM, Dan Williams wrote:
[..]
>>   
>> +static inline int dax_mem2blk_err(int err)
>> +{
>> +	return (err == -EHWPOISON) ? -EIO : err;
>> +}
> 
> I think it is worth a comment on this function to indicate where this
> helper is *not* used. I.e. it's easy to grep for where the error code is
> converted for file I/O errors, but the subtlety of when the
> dax_direct_acces() return value is not translated for fault handling
> deserves a comment when we wonder why this function exists in a few
> years time.

Good point!  v5 coming up next.

thanks!
-jane
