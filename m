Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DDE7A9022
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 02:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjIUAV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 20:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:21:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF0CF;
        Wed, 20 Sep 2023 17:21:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJ3ux004048;
        Thu, 21 Sep 2023 00:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g6eYOWn/A8PNS5z+2DaQmvYppz2axjUyDSlpAEUHoo0=;
 b=PTyE3l8SGi25UGvQ672EocdRHUfhme0WUSkGLTCgwpxzrG+I0JfpAD3f4UEu8gMKwe3S
 z3aypKNjQysyk7DzFY3zyocvW/pVzYF8pP6D5z5X5lbcvHqbl2KquREeqTkmHDJwbXw5
 IgJd8Rnq7i03ADux1kyrWVXwGlgafSOBktllmdFzQ/yIZeO5dBLjmHPgzZ5QxV4D2ol2
 u0lNzIxcZ04/mCqP0249sbHR90V5LKAOFVrxv4K218RoW3LcYu/EmiP5kcq0oxukHUGv
 Lg/27qv3vykoXrs+qHwbBBgCFYuAZ24lTEf67B3Y9gsdZSxUN4/yfmm9HMxc7TE4gjBA SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53530n4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:21:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38L04SH9012141;
        Thu, 21 Sep 2023 00:21:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t82ws2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr5K+hh/F6Em5k6054PK+rmAtwC3JxavPI78ilGlbJy+5L+ZhOIAWJRxBQAzFCdz1cuZkwXAukX2+3xHf8tJri1XdU1/qRp7xnJx9t48gaGSxQVF8hHQynQS/EVrfgtMy+kKorQfrzsfqXR/uec40ZdLiPU3m53UkRs2649A/iN7rCW4+vgSFtNGfA1VllGs92Evunmdmygr5G26s22khM7a18BSXavLGp1k1DjaGzjZ9W2uFeD7gBlIIdALkzfi2Nj8On6d9Ep1aCj/Eg5UAJbJBFlsUhMbjZ61RlP73POQj6eu/QyJWzl6cG6DYHofW07dxcHdwaFXwiEO+XaTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6eYOWn/A8PNS5z+2DaQmvYppz2axjUyDSlpAEUHoo0=;
 b=eboJkPLd2Fry99rkQ18YmCREZ7ziktV9r7C5B63KILJgrNOCyq+QzLnYuILvhECJnmr0BNG9wEsYsjeihHdKZuFtxtPyWUSdelyAEdvkb7UtJbDlphsspUeV8aPaCPbigjJTy33T8XJ+a8kF2Bxdl/PD2EZ3YA6RAyoxrwaQzQKpwogbZj28/2v2t3BoEvkpjcm9z/vZ+7pGcic/gmI4TkI/TWh3S+H8rKz0mGMsx/o63RD1Q5ErZpHebzVM6cxNTlz7Dehu+HFBUyyHKTBumpTbiX4+S6V/XXKrtZpwUCQm+YUnizHvt9fWzUFqvWPU+Fvn5epvg+d9JO1mn3wucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6eYOWn/A8PNS5z+2DaQmvYppz2axjUyDSlpAEUHoo0=;
 b=u+LDsG2GtIv8m8ZJPjC0jyHjdB1sOn9cC+/lj8B0gTGoYwYgh0A2TFFzvpryCURpDotft43+JTCuCNDLSjztdV5+iraSBz/KerU8JutCF0nWy9P56LnCTYlUS8fF1XE6jJk5ABKr4yPX2zmoQ6MSQhZXQT8KyQ4vlW6l4yH2Lto=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5028.namprd10.prod.outlook.com (2603:10b6:208:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 00:21:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Thu, 21 Sep 2023
 00:21:18 +0000
Message-ID: <0a4b62d5-27b7-a09c-7112-f8e1ec6070c5@oracle.com>
Date:   Thu, 21 Sep 2023 08:21:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
Content-Language: en-US
To:     dsterba@suse.cz, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
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
 <a5572d9e-4028-b3ca-da34-e9f5da95bc34@oracle.com>
 <9ee57635-81bf-3307-27ac-8cb7a4fa02f6@igalia.com>
 <20230920183756.GG2268@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230920183756.GG2268@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 033165f7-f009-4ca2-c74e-08dbba38acd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JXV+snPzcPHAyx0JmI5JTV1cFOQEVf03MbfJiKujFargOQcKdfF5aYhKBne3L6m9LM6/IRHSggrL2/y0o05Qe4UI2OiYUd+0wp4l/yfrCcN+FK9UDBjTCvrh0JeNoGNycow15/swLZDPhjLSTD9LCHpeItYPPFyxf/GR37sWVGnDLW8TowwUtzYk5GbdJwGx/7fY+MmOwtMoCWx3CUuYFclXXRvDIXGYR1hH5+VSZDPvFEnnOk/96KoE5/INuF5ZFvwnUq52UdAnQTkf2wfqCZlu5LahVA3k7XCwXI7Ztj6iou/tCCbhnvvlPmnTViZvxaEEd59A78x4Ed5q9fkMFdjKerL3VRfYUELNh1DFm9wTQhbtT5vlU9SVvpv03rQDZw8bsTprPtE90Bh1aydW4Sg1fz3bhT3kp3LNFQDPggAy7w6GwmhBbJrUBL312Tdc3dphkx9cLgscOCkxcHbDMtxRj1QmEnPDMDf9JHaa8gR8LT8+6vwkNTqojyaysJq8cKqhtlgf/UFjUUON7VuWXfEe4AgDp/SAepXcby8P/vQzAlIrVoA7c0Ech+yjLuEX9+BRfIKLmkk8qjGtYJU4NdXC00+5Jr6rVwX6PhwPopCO34PBWscBZvLp6SihwUVKq+bn3CXWLawyL6zC634Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(186009)(1800799009)(451199024)(8936002)(8676002)(4326008)(83380400001)(86362001)(36756003)(41300700001)(26005)(31686004)(2616005)(53546011)(6666004)(6506007)(6486002)(6916009)(316002)(66556008)(66476007)(66946007)(2906002)(31696002)(5660300002)(7416002)(38100700002)(6512007)(478600001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFzT3JIVG4xMlJBVCtTbDF3QjdhV3RyVkJkQ2JZblloNzhpa3J5WVRTWFNV?=
 =?utf-8?B?b1ZpN3BkSUd4ejdIWkhCbWpPTlVxY0cvaU1aaXdsTTRlSHluRlhaRGVDSVBD?=
 =?utf-8?B?MFJqL2kwQ3pNWUpBSlZPeGlVMWZhV014NVJleGVvejN4aXczVGpKdVNjbVlq?=
 =?utf-8?B?cGlZdGdncmwrczNmNFNOZGh2MkZIRkFhUXg3WmJUbElEeGFCV2cyT1ROa1kz?=
 =?utf-8?B?bjNrUTM2YkFCcXNFQU5HU2JBcGZGWEd1TnNabC9UNGZtVjFybFUwVUVPMVMw?=
 =?utf-8?B?QWZKOTdNWUlwWVpJbTArTURPMFNQNXh0ZHh0YkpSSHljSjlzczAwVVpEanRU?=
 =?utf-8?B?M0IwSFNxa3pvL3o0QmZ0LzVoN3JHYldnQlVoelBTYlZLZzVSSWhHbWhaRzZy?=
 =?utf-8?B?QXBBUFhma1A0c2hjZDNIamFKSTk0YnNGWkhOTVNURlcySjZmTmk0K0pkK1ox?=
 =?utf-8?B?akY3ejZsOFgwTzZyZXh0QzRMQ1A0U0Z4bkxEWGIvaHl5ZG1HK2pnY3FMd0xD?=
 =?utf-8?B?NWpSYVhnMWdwRVRjUjQ2N0RJTWg4T01LRVpUejNlQkVxVlZFcUZQOFJNdThT?=
 =?utf-8?B?bDZVL2s4VWFhc21sZGtJNk1ScTJxblBJK0t0RVhneTNMZGFUdTh2OWJnTDVm?=
 =?utf-8?B?eGJSbDFnaldwcjVOMWxUQUlOVS9tajU3RXRiRDcyS1BBcXpwb2YrNEEyeml5?=
 =?utf-8?B?Q0xIaUExaDBRWHpvc0hxZ01QSlU1SUVESVpFZUJIZFBnZGRFUnVzcU9aRWh3?=
 =?utf-8?B?WEtZbWMva2VrOEhQYlhjeUt3NnJNUVZJeW5DcGJJUG5vdGFkRTVVbllmdlhZ?=
 =?utf-8?B?ZVpZU2UzaVBOS1lyTFpwelRCTXVmWWdZYi9IUXBjZ0wzaVJrRm5sNEdteWpi?=
 =?utf-8?B?czd4MUcvUmtwVkVubUUzZ2VyVDR3Y0tRNHJXVVE3dysySllFeVFXRjRoOGh1?=
 =?utf-8?B?cGdMaUJodmN1b0MzMnNEOEo2ckh5Nnd3ZTdrYXhZanp5N001RVVlZXNzL1do?=
 =?utf-8?B?Qm9wVFllbFZLQUlLQzhJZCszQVpndzZlMVRmU1lMQXVGeUgwb25YVHNSN0NG?=
 =?utf-8?B?NUlFWEg4dVhwaitrdlRjbEZkQ0tBNkNNcWVWd01PTXROMDk5OXpwclA0bFRh?=
 =?utf-8?B?cEVtNUxVWVdWOEg2cVdERXNUd0FnbHdMNm93NjM2MkVtQ2RWQ3VtaUkvVDBI?=
 =?utf-8?B?ajNKS1lHV2lqbE50YVFVQmJ1UnRpLzgxdDI5d2dsR1Z5MGsySWQrMUVCanpj?=
 =?utf-8?B?VWhqdi9YcUViUHFnVVI4WjBqc0tzQ1Q5UEJPcGVicVgxWXhnNUJLMUZFcWlp?=
 =?utf-8?B?bmdWbGpGRWtOTmhhVGIwQlZlODJFb1Z3WmpaOHduTkttNEJOWGw0WHovSzRE?=
 =?utf-8?B?S1RKVU5QZCtTV1JKZnV4QWtNc2dveVZYclNWV3dYcE81c2IwTU9LRFFXRXhs?=
 =?utf-8?B?eHRMNFhxc1ppMXNmVmZmRmZJcWVYNExKRVI5bUtoNmlDWE90LzJ1bTNBbG9k?=
 =?utf-8?B?SG4wdDNPMThzQ3pUVG1pTjdrWFEvejdUcnVIVUUva1R6cmlyUW9NdEdhUlg4?=
 =?utf-8?B?YWdvbW5yZ2o0dDZHd1JUVC9tOGwrUDE4d2xXekdYeElXajRVb0JMaEU2Q21v?=
 =?utf-8?B?MFJYb3pmcGQycVBkTGhGdzFSby9SaGdzSUJacWhtK1ppOUU4bUdDVFdqODlw?=
 =?utf-8?B?ZWV3L0p2S0dhQW4ybWxxQXIreWF4b3E0ajVQR3NmUE9BcFMrVS9GMXp1WjlD?=
 =?utf-8?B?akJGUUU3K3NLVHpQSUl4a0hSMnVvbUF4aGZ0dENWczlwSFZrTTZ3N3BJdTNL?=
 =?utf-8?B?SnlhWlpRR3ZOMVdDUjE4Nm9qTkxkSmJJREVMWGhqVlF5bUVJbUVUd1RZYWJ5?=
 =?utf-8?B?ZWR3elIwRHZDT3gzZk5WaEs4NW8xOG9rNEFUZWI5M1pNV1M1anZUdC9TQ3pO?=
 =?utf-8?B?Y1NLeVNyK1NzK1Jucjc1UUgxTUI0VGx4VSs4QmRETXpjckx1b3pUR2thbWY1?=
 =?utf-8?B?aGEyZFlZdWhTUlllYUVDUzg0aFpLNFNYSnVUQS9IeXZkVjdCcEdEK2IwclYz?=
 =?utf-8?B?VWNYTXFJTWF3NVhkaHljWFpmbzBJbE16SGxHa2FGL0lQSjVFVWVweWNUenJy?=
 =?utf-8?B?emQ1VkhGUGRGYjNmUzczK2VlRm9qdTNuNlhBSG10UUtnRzRuLzZ1VGFWOVFD?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L2VXNXBnODNtVHV1cTYyVUxla2wzU2o4WHFnNUovcWtFYnFGakF4dWdkbjFp?=
 =?utf-8?B?RDRhaEl3cUNxaSt0dys5UUtDQ2d4QnVWV21kbE9FQStZb2dwWGR5dzJDRDFu?=
 =?utf-8?B?Ynh5RzJLdHhUbVhhOFJFVnNmZENFMWpNd0hOb3JvKzhkMUE0bzduSWVaMG93?=
 =?utf-8?B?U3RvVlUvcmdKdTJlMHhHbnJ0S2NmcFdYWFY0NERyNklWVUc1Nm1CNHd6dTFV?=
 =?utf-8?B?aVZ4Z3BwZ1YrT25MQUlTUGRPZ3JybDJabThNcjFTeTQwSmJyYmZNYjZEbDlQ?=
 =?utf-8?B?c0V5TjJOYjdwdG44Y2VobHFWbXBnWlRiRmdUb2twY01iRzVmUExJNFNPT3VN?=
 =?utf-8?B?WlVPaG1PZEErWTFSdll1Y3ZYQkh4S3B0UEVQS1A0alZMY0srN0M5QXQ3Unhi?=
 =?utf-8?B?RXBHNU9BYTlJakRkSWFBZUk2ODAvZDg5L2F6dEFOWlgvOGlYNTNCMWZqSHFE?=
 =?utf-8?B?a2w2SHVySTlDcXNWajRsL3hVdmQvSnVaRGlFOXVuN1VyK1Bod3pMejAzV0dm?=
 =?utf-8?B?S2dmQThFeTR0VnRDOHhrODJtWGI4VCtpbzR5NzBnU21VQkNVOWxMMjlVR1FQ?=
 =?utf-8?B?RC81d0ZTQVlibTk5cXpsSmtkWUdnZFEvNzBzeFpkeFZpSG0zQnowamFkU2gy?=
 =?utf-8?B?dU9lSHVXaW9yVlRDL0JTdlpmN2o4WUhCaVUxWmtjUXBUV2VOUU9sWEhPMnMw?=
 =?utf-8?B?aXJ3QmE0eW5LUXJzNTRQZXYzMWYrVkh1MmJ5aUEra2RnSWpMK0N5bE9lb1ZP?=
 =?utf-8?B?TjQ0RldoYnU5cHFlWTZ0OXR1NTdJYTQvN0xEQXljYS9Lb0ZjNTFFWnp3Rzcz?=
 =?utf-8?B?WktJQmV6NGkwRHZxS1JJckJVa2w0N2haRUJ3ZUdEZFhhcGtNd2l1M2tmOTZW?=
 =?utf-8?B?SHNiTjY5ZVpkelNVaDhhcWc0cDNueWtYUFJoK0NPMW1RZnV0Q29nWWlCWDJa?=
 =?utf-8?B?TllXdjNZR1VDc2dGWS9GRjlBVDAxbjM3NEVJaE9kK2IyZG5IbC9xUStkN0J5?=
 =?utf-8?B?bVNDWklKTUlmR3NoSGhtVFpWcURJRjRaQ1o5WWhNeWxFeVREQTEzc3pNWWJk?=
 =?utf-8?B?dE5jWGwwQUYrdVp2YjJSV1FNSXR5dEFiQzl0R29pYTYwOW4vL21UWGZkOFU4?=
 =?utf-8?B?S3plNGpxUDVURzlWd29acW9PM3ZNbXZvaEswVlBES2Y1RVdCNmpQdXJmbkdn?=
 =?utf-8?B?Z1oxRUNXaStTNjZhdWpYb2xlOXprRXR3S2hSeGE4SmRGcFF5TkVhSVFyWmFD?=
 =?utf-8?B?TjhTeG96OVdBRlJ1ZytjdVFIUEFzT3J6UExTbTQ0M2JoSkhIZjdwTG5oOVVW?=
 =?utf-8?B?cmU3NXBEZ2JxejY0MUI0L0QwU25RQ0hJNzR0RmhGK3lrdWVEK0dNVzhKMnNR?=
 =?utf-8?B?Q1gyV2lhVWMzN01KZXlIUjdkTnEwMkRyNEJzMVFTdWpLbUl6Q25HZjV5Tkcy?=
 =?utf-8?B?ckloWTZ6UFd6dXFKbXFydDUrVTZMSVM4NHNKbCtBVHg4OGxsWHFCVCtmdXFu?=
 =?utf-8?Q?jsGFzc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033165f7-f009-4ca2-c74e-08dbba38acd4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:21:18.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GZAVudGyOYm8Mc2s/Pcq91YX6WlvrgMGqh8q2xYdeaJ5uexr0ThKl09S4x+g75xH9LhbBjAcHJZfpP68VbBGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_13,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210000
X-Proofpoint-ORIG-GUID: tbp7borWmC8XUFwUQbCXi8O2p-miGYDM
X-Proofpoint-GUID: tbp7borWmC8XUFwUQbCXi8O2p-miGYDM
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 21/09/2023 02:37, David Sterba wrote:
> On Wed, Sep 20, 2023 at 09:16:02AM -0300, Guilherme G. Piccoli wrote:
>> On 19/09/2023 02:01, Anand Jain wrote:
>>> [...]
>>> This must successfully pass the remaining Btrfs fstests test cases with
>>> the MKFS_OPTION="-O temp-fsid" configuration option, or it should call
>>> not run for the incompatible feature.
>>
>> I kinda disagree here - this feature is not compatible with anything
>> else, so I don't think it's fair to expect mounting with temp-fsid will
>> just pass all other tests, specially for things like (the real)
>> metadata_uuid or extra devices, like device removal...
> 
> Yeah, fstests are not in general ready for enabling some feature from
> the outside (mkfs, or mount options). Some of them work as long as
> they're orthogonal but some tests need to detect that and skip. In this
> case all multidevice tests would fail.
> 
> For test coverage there should be at lest one test that verifies known
> set of compatible features or usecases we care about in comibnation with
> the temp-fsid.
> 

If this patch had undergone verification using fstests for a single
device, it might have already resolved the data corruption issue I
recently reported. While it could be an isolated bug, having fstests
confirm that 'yes, everything else is verified except for multi-device
support' would be helpful.

The MKFS_OPTION="-O temp_fsid" config would help create temp_fsid in
fstests, it may not be too difficult to verify.

Also, as commented in v3, btrfs-progs needs to support listing single
devices with conflicting fsids while they are unmounted.

Thanks, Anand


>>> I have observed that the following test case is failing with this patch:
>>>
>>>    $ mkfs.btrfs -fq /dev/sdb1 :0
>>>    $ btrfstune --convert-to-temp-fsid /dev/sdb1 :0
>>>    $ mount /dev/sdb1 /btrfs :0
>>>
>>> Mount /dev/sdb1 again at a different mount point and look for the copied
>>> file 'messages':
>>>
>>>    $ cp /var/log/messages /btrfs :0
>>>
>>>    $ mount /dev/sdb1 /btrfs1 :0
>>>    $ ls -l /btrfs1 :0
>>>    total 0   <-- empty
>>>
>>> The copied file is missing because we consider each mount as a new fsid.
>>> This means subvolume mounts are also not working. Some operating systems
>>> mount $HOME as a subvolume, so those won't work either.
>>>
>>> To resolve this, we can use devt to match in the device list and find
>>> the matching fs_devices or NULL.
>>
>> Ugh, this one is ugly. Thanks for noticing that, I think this needs
>> fixing indeed.
>>
>> I've tried here, mounted the same temp-fsid btrfs device in 2 different
>> mount points, and wrote two different files on each. The mount A can
>> only see the file A, mount B can only see file B. Then after unmouting
>> both, I cannot mount anymore with errors in ctree, so it got corrupted.
>>
>> The way I think we could resolve this is by forbidding mounting a
>> temp-fsid twice - after the random uuid generation, we could check for
>> all fs_devices present and if any of it has the same metadata_uuid, we
>> check if it's the same dev_t and bail.
>>
>> The purpose of the feature is for having the same filesystem in
>> different devices able to mount at the same time, but on different mount
>> points. WDYT?
> 
> The subvolume mount is a common use case and I hope it continues to
> work. Currently it does not seem so as said above, for correctness we
> may need to prevent it. We might find more and this should be known or
> fixed before final release.
