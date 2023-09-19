Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EA7A591F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 07:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjISFCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 01:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjISFCk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:02:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5777FC;
        Mon, 18 Sep 2023 22:02:32 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK3ppD005683;
        Tue, 19 Sep 2023 05:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wjBe+Y4zfOU6BozgXJlmgOhJ5beVKJbPCl5ztdxBans=;
 b=CDhKz/l621NAnGN1O4P02qFeD5CPQERzRapoUlsdGrWH9cs4hmVScpezIlG2LJCi2Ark
 vAKbTNZZpN0MYtGd+YUWfpdCeX++6oyWOyXPjh4fJo1U2/1N5uKHVWierZchWY/azynQ
 aKNUy+HplsL6asTIVsIIppvzaPaa1QD63DsSQ1ov7s0QSKoixUxhLnKVC4hzcXLtzr1n
 ZiSmWHWf/Kj/WPYkbhQaECmO4v00TLeIF1riMTMNz2YTEhR3jc+kbA13jLWTao9+er4V
 zJDWaLVTAsV6hTfKSlFOvMLdPuIxUZdhE/KTiOp2HRSgtdZLo8athH2fgX9lwc/WhypY jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd40yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 05:02:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J4WB01027077;
        Tue, 19 Sep 2023 05:02:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5dn5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 05:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOQrayma5zrt7pGIjJto3cCNPgICFZDCIQrBuAWX/ouTiIbP8FF90/5Je/uTrMV66sFpiZCw0w7JU/DFaGwL3V8MuPI27B8jMocKunkDuiXJAtgg2GSv7+FnOfud1ENVeo2+mvbVYuOLtK+ogjSzRuDkIdHvMtebwbCMQcHUXW3FDo8Ke1XFj4U/JhFZwAF8ZhSowvfnb9Z23GoWUjNZm+nEe3zJKRiVSQhuWrfGydLqq/zQiXPtwQxmeOahUOtR5MhhKqyv0g5KdyBUz6bH8HDH+tAwF9rqMdaJT/4sjUx14JgNbMkQii78CdOioOUeX6tCdBwGtyLx0UMV6Gc16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjBe+Y4zfOU6BozgXJlmgOhJ5beVKJbPCl5ztdxBans=;
 b=kilS2J1rnXl14psEjH1WDRznzqkUAgqsSz57jg0yMYAN3kasFOlELtMjt44cDuR54jMMfuajzTTy6cZF1+QFRgCFr7jSmyHdXGqQGg57ASo9+9KY58BJzpxbkptZ1wSxsIAdCKhlFXIVvO3dnWueZzFRLT9NY32LLb4kltP9pPCZHnxdKx7YFqPEtoREIaRKFLqz9OWUemxEP46ruE81d0gxVYXi93a9wGT6yD4qHNdREVTuRq3jRFNKjnhJTuxXRBQ+Bf0WZtT1MHCTQm9xSAQflSMWtiq9deJvdNzXYA/AcHuoJOVIy1+RBsAsWNbQFzWBqbSJhIkdNzM+z2UVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjBe+Y4zfOU6BozgXJlmgOhJ5beVKJbPCl5ztdxBans=;
 b=kchpVgwOSgGpWNF0Vu9q/4XC5ZRRouq9CaXIEtJO3IOz+L32rsjjbtfn8npMJWszerKBzCHqyHoUpJe3QXH1QMRcfKKcsVlPWuE1p+jPrIIn5icTQJKiyEz7G9ZcenN049HVpVrPVruFBVbNzVc++XBtmUyOYRdz6/zf7CD5zs4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 05:02:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Tue, 19 Sep 2023
 05:02:01 +0000
Message-ID: <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
Date:   Tue, 19 Sep 2023 13:01:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <20230918215250.GQ2747@twin.jikos.cz>
 <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7925e16f-33f5-402e-dabc-08dbb8cd8f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQFigzrHWnsewL9hLC03nAfDbMF1+hXeE/N/XCeKscC4XdL5pROmX23r1d2T9a3HVyPp5TMbyd2N57kxV6TY5u8TSmmqIjgpsxiFTa6n4PapRNGflfXHrDuaU/Q2DUEFWMlRJJ0BR9YLrxDDq4QQFLeexKBNDU5qQNZ0IqU3rEOHX53YfjpKcMZFw28KQNxZza9B4Qo+Ix9JZxAO4+jQ0CF7Jq5dCMyeWSFlVQQqk17BN15vwYQypGoo9H6qxOx8mwWqoRyq/+O5ob73rTFQVRVyYaFSmdD9DpJU2R3HVlIc37hTZVMpQkmFQlxYPVtYQVaTdy7XyTyHewnpMgUYs5ZZyKkyAptz6u5EV9uzozJlBaa6hbQ86XrLkbK5psOJcFwepLWwGoHpithxJ/MqyQcfgSgkLitfo4gydpBwYpQuG4xS7mav7X5zwBbsd5Fc/L4frTXolT3OZiSjSI0wHmzwxHWKmP3zjZkweigRcov4D3Jj6FGsZ5nnm7/8OsMtVNpa4j5HmjMvUuSDxM2j9zNUVMrjPF+60Yiibq2rAMQIcuXZNsaZLfCm+XVHzBm1AhRr3WLs3ydM2SxBhBbKqL6uUKsa2gWP5uNroTMuLXbI2upqIjKWjwNSA2O46NHo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(186009)(451199024)(1800799009)(6512007)(53546011)(6486002)(6506007)(36756003)(6666004)(83380400001)(38100700002)(86362001)(31696002)(2616005)(66556008)(26005)(66476007)(66946007)(7416002)(41300700001)(316002)(2906002)(5660300002)(44832011)(4326008)(8676002)(8936002)(31686004)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRyTk5tcXVnRG9sQ0Y2SWJQSkNnUjNSY3MycGd2R0JFV1p4Mi9RdllJZkdo?=
 =?utf-8?B?dTlTVk9EOWpCYlRnTncwN1p6cUthUmJJNEJxa0dBSDR3VmIyL2YvTE83R04r?=
 =?utf-8?B?aDF2UzdjTzVXdmI3dlVIM2M0eHMyYlg3Q21MYnRyd1ZSbG9KL3R5cGIxRVAx?=
 =?utf-8?B?dVhCS2R1OHQyQTRRZ243UVlvZHg1bWh1ZXQ4bFR0SjVlK3ZFTXVLZUViUCt2?=
 =?utf-8?B?c0VlV01zdUNDcDVTWGFJRzYzNCtMVEhjZ1ZmVWlLYlZNVXVOaFNUVVJOV0JH?=
 =?utf-8?B?QjJwenZmdWR0N1pOeW8wUTdtMUJrTklFTGxpeEZpdmp4Q1ROZDl3VEIvV0lx?=
 =?utf-8?B?dWxJdEZOaWg4UFRXUkNWZm1VZGVNeDVJVkp5anhJbHg3UEh0clUvSkhCcmZ6?=
 =?utf-8?B?MnNiYnZUUmtWdUt0QkJwVmZuMWVCYVlqV0hoaUJta1pJVFNnR2FMVUt1cW9t?=
 =?utf-8?B?dzNySFAzeDloVitLaUprU3MxNGtySWdIR2F0UitRN2NYbFowS1lKaGZteXRX?=
 =?utf-8?B?UVgvWGJQQWcwYW10eTJsNkhGUjdwQ3FOeVdWWmZBUEdBRk1xSUkxSmVBT3R3?=
 =?utf-8?B?eUt5cVUyUzZBWldwMzRYWmhzZi9QQWl5U2pWNWE0K2JuT01Ib2ZSUWpITWNo?=
 =?utf-8?B?bVBIV0tDR2dNR0ZGQmhMTVdYdUVua0tIRjR1WlhLTndtZjdqUGplSkhybjVR?=
 =?utf-8?B?SGdDcFcvMW5maWY3aUFHRmhOVHZJQWxMU2p5QnNBYS95eEFBZWRzcitjVWFW?=
 =?utf-8?B?cTFlbEtiM1djK2RKNHdhZXBmRE5CMmVvZWs2alV2a2RXcnh5WXNtQTFLRUZ1?=
 =?utf-8?B?b3llbmFFNHdZYytEN1ZVamkyenk4T0pyS2ZQckJ2QXNsOUdWRTM3cHFGN3pS?=
 =?utf-8?B?OXAyYnhrc0lPeHhVYXFSOHFTOHlPbkhqamhyTmhTdmd1Ykg3SnNtK1AyUUpz?=
 =?utf-8?B?aFJPMnJ3SWNMZ21lWTdPbExOaTZYRGFVMGRXeTNFa0J2bTNSejdUNjhKS25o?=
 =?utf-8?B?eFlxdlB1MVhxYXoxM3JTdGo3Um80SVI2eXV2Ym1rVi93N003R2ZHZG11Tnp1?=
 =?utf-8?B?QTNlTTV2RERGdENybXVOdWFmY0U2dTVESGJ1VzJoVnlpMHJSdGlWcExVdVdm?=
 =?utf-8?B?NTBKWEhxb3AwM0JYT0tQY1VPNUdLaVZLRTlzd0FrQThWWDh2NFE3V1dScU9P?=
 =?utf-8?B?YVpGUklrZFN2UFhvMTVMOThaaFdZaXd0WFdGNUZTdHdvOGo2ZXU0Vnd2QnNI?=
 =?utf-8?B?MFcrbENtMjVBZEdackwyMVZzbS9rNkdPRGpxM2M3RTdXV3lDd2NidjJSU3Nm?=
 =?utf-8?B?OGEvTTh0akhOaU5PYVhYRjlPcTRQUlpxL0J5bmgxWVhkcmQ1clA1UkxSdXBs?=
 =?utf-8?B?cDNOUDhuT21DQ2dzaTFEeG1LSDdlbVlhRVZrZVdFOXNacE0wd2l6UEk2K3g0?=
 =?utf-8?B?dVRoZTJxN1pTTjhFZmtvZXdlZXV4WnRTYnFxd3kwbkp3Y3h0SmhmejZpR0FV?=
 =?utf-8?B?TlRvZGFYdmRjUHh5a01lS0VySUxlVVpUVmhmU0w0UWx2Ymc1L3ZXWEtOSy9Z?=
 =?utf-8?B?dVpGQlB1RjlOQmJNY3RMSGwrRjJ5U1NIYThYNUlsTm0zdEcwMXFrWCs1OWsr?=
 =?utf-8?B?K3VrVFRrU2ZxYWhzVjhKSU9oUjNFZG9FdDgrWmNLRmFMazRuSVlyVlRjYUdN?=
 =?utf-8?B?dFNMVVR4OTBISjBDRjlvNGZ3YWo0VmFhVTJzbG01dENaeStWTEJyQ2tSMGk2?=
 =?utf-8?B?K0lFTzBUOG1pSFFabHUxb3Q2M2l1eXFuZUo1c1FiT1o5NmtyRDRnMGVaaysy?=
 =?utf-8?B?cjM0TGQyQ1c5bG9NR0FoOFh0dCtkZHBNTW1LSkQ0ekVaOWZsd085cXdJU2lK?=
 =?utf-8?B?NHJWRG0xUXExOHorMlRtODZtWFhieFQySEw4LzVvTEZLVEhNQXhIRFM5UHhU?=
 =?utf-8?B?b1p3NFBNL2hFVUlHOTJPbEJrVzRFZXZTSWJnZG1nVWNaa0JTNTBZVGFHVUhm?=
 =?utf-8?B?aCtpZkZGN21LRm51RmN6OUFhU0ZtVkY4azlVQVNXSDY5SWRjN0dNRmNOL013?=
 =?utf-8?B?c3M5QVRyWVFsNTRYcnZJU2pCK1JETlVDRDJySnFyazI1cElpaGd0UHhXUU9V?=
 =?utf-8?Q?d/mb0aegcwCwFxNvWxz9BMryP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTRlVGVxQ3BkNFJvVEFPZGUxLzJqK3l4dTQ3ZmNOUDRZc0lNdHJwZE9pK01x?=
 =?utf-8?B?dktBWk81c2FCaTBZWmorVWE1dldyVXdSSGY2OUZhOUhhWm5GWW5SQU0wR1BE?=
 =?utf-8?B?SnN0dlVYYkxLMk1RNGlZclFTd3p1Rk5paTRnTVZsQ0dKZW9mK3ZOYUhvSDd0?=
 =?utf-8?B?dW1waGJlblphbHF5S0Z2YldqNG1XM25wRUJyWVFkMXFJekVTcS9CTE1uV2Nv?=
 =?utf-8?B?RVpMS3Jvcy9IVzlzSklYbzNqS3MwN1FPalRKbkdxQk5YTU5Ebms0NGEyVXdl?=
 =?utf-8?B?SGJ4aWFuN0k3WWd5RmtwQ0phMDlWbytkTE8zNGRTVXZXTVI3Nnh0SEYvSDZx?=
 =?utf-8?B?MDRZSGxQdGtjL1JRRGljVE9CbEVzNXE5dEErbGtrK0poZnBaeXo2YUV4ckxK?=
 =?utf-8?B?UTBEVFY0ckRvRzR5MkZUQ0U5SVpWR2lFM2FDYkZvM241V2ZWcVhJVEhpbG9V?=
 =?utf-8?B?T2Zud25EYTFqWmhyUnM0eGFkZUlDVHNJMXJ0STNyS3lpZWd6bjIxVzhncUEr?=
 =?utf-8?B?WTBYR0s5R21HcEpYZ0dmSStITmJMVStzK1hQa3MwYnRWWFRIcDVnbEdJc1pM?=
 =?utf-8?B?Y1ZBbjRPZEp5ajEzeWdQdi9LQUlObHliTzVWRURnT1ZZTVNXWVc4cXQ3ZHFY?=
 =?utf-8?B?VTZLR3RvbGswTXdGcEJPaUJhbWlRbEFMNDR1RzhON0J5VVA3cndXZmhTVEs0?=
 =?utf-8?B?aEtZbEIrNVFFUytOMkpZTDY0NkN4UVVpajluWUIwT3VDMWtDbnhyWE1zR282?=
 =?utf-8?B?L2k0NGtiNFJxU2EzN01NZ1Z4ajBRRldLWG9LTTVzRlVYLzUxaVJEci9RNCtV?=
 =?utf-8?B?VUFnV2Y4OTFidTJ5R2NGOTNUZld5TlpwZzBEdDl4Rk9BV0FpNXVhcFBqcmp5?=
 =?utf-8?B?aEs4OWpGKy9rY1NqaGFtdTJ6ZUMvNldrb25ycG92TS9YT2EyVDFmdm5SWk5B?=
 =?utf-8?B?enU2aXBoczhSQXBwOG15cDVvVjJtSmpJZ3dQSXVsSVlTL2lsQmJLeUR3MFBk?=
 =?utf-8?B?WEo5N3JBZFNLUFh4NXhzVHBRMkFtUHRnblZyNDRBWFoxNUdDN2crQVhOUkdP?=
 =?utf-8?B?WC9wY09nNmJaRnV1VnJRZ1VPcGEvdUVIWHZrZzE2ZGZsODdyTklZY1FUMkQy?=
 =?utf-8?B?R3NteVBsamJOOWtmUlBzbXRiQ2xRRElJOUJDRWhjNThFUWxVK3JoaFhiRitG?=
 =?utf-8?B?bVFTVkpkWnIwWHEvTlF3UHJweXZBNEZFWHdxQTF2MEJid1AySVFoZzRvbllm?=
 =?utf-8?B?SjJTbUh0UzdMMURtSG9PN2hBMWZxRUZsTTE4OXljeEMvalZBQ0plc09HMTM0?=
 =?utf-8?B?ZXIwMHdTNlZ1UnRPK2NwRVE1OUFpYU5KT00rUUtZNWJnNjJ0b1RvblVXVy9l?=
 =?utf-8?B?d0J5ajhhM1RwV0NMcmprKzY5dlg2WDZvbldFQU9jR0JXOXQ5UzdnYjYxbjZn?=
 =?utf-8?B?TkU5eUZtK2dGMnFDOTltb0RPL1FzRnZ1ek9iQXMyTFVKcFI0MURFRFFpVUY3?=
 =?utf-8?Q?+k8ZEY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7925e16f-33f5-402e-dabc-08dbb8cd8f35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 05:02:01.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UJHNiSsYtIvYvO81gUilFs6b36Xdnt+yxPdxtALfEqNy53IjAgIRI8Gu6np41f/qXuiWE/wRgx+p0/knsTlog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190042
X-Proofpoint-GUID: TGJEMgfTL8hQcsiCZEYRAOJk3hWowKWD
X-Proofpoint-ORIG-GUID: TGJEMgfTL8hQcsiCZEYRAOJk3hWowKWD
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/09/2023 06:21, Guilherme G. Piccoli wrote:
> On 18/09/2023 18:52, David Sterba wrote:
>> [...]
>> Let's stick to temp-fsid for now, I like that it says the fsid is
>> temporary, virtual could be potentially stored permanently (like another
>> metadata_uuid).
>>
>> I've added the patch to for-next, with some fixups, mostly stylistic.
>> I'll add the btrfs-progs part soon so we have the support for testing.
>> The feature seems to be complete regarding the original idea, if you
>> have any updates please send them separate patches or replies to this
>> thread. Thanks.
>>
> 
> Thanks a bunch David, much appreciated!
> BTW, thanks a lot all reviewers, was a great and productive discussion.
> 
> For testing, likely you're aware but I think doesn't harm to mention
> here as well: there's a fstests case for this feature here ->

This must successfully pass the remaining Btrfs fstests test cases with
the MKFS_OPTION="-O temp-fsid" configuration option, or it should call
not run for the incompatible feature.

I have observed that the following test case is failing with this patch:

  $ mkfs.btrfs -fq /dev/sdb1 :0
  $ btrfstune --convert-to-temp-fsid /dev/sdb1 :0
  $ mount /dev/sdb1 /btrfs :0

Mount /dev/sdb1 again at a different mount point and look for the copied
file 'messages':

  $ cp /var/log/messages /btrfs :0

  $ mount /dev/sdb1 /btrfs1 :0
  $ ls -l /btrfs1 :0
  total 0   <-- empty

The copied file is missing because we consider each mount as a new fsid.
This means subvolume mounts are also not working. Some operating systems
mount $HOME as a subvolume, so those won't work either.

To resolve this, we can use devt to match in the device list and find
the matching fs_devices or NULL.

Thanks, Anand


> https://lore.kernel.org/linux-btrfs/20230913224545.3940971-1-gpiccoli@igalia.com/



