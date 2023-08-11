Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CE779617
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjHKR3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHKR3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:29:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A1B30D5;
        Fri, 11 Aug 2023 10:29:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDUUJ3014430;
        Fri, 11 Aug 2023 17:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=QVi2d176fTDfknkkhiOEuMqH/u/yKYYNHfZ9/8aRMP4=;
 b=Uw3MntP4EmARcZVcS2IF7FAdjpNf3vGS0+PDi8Cver6AW1SEeWM6PCnmMlab5FEm4SsR
 s7Um4usMBpTk4sk2lK7p6X0sGcerin9ODqOO1+AWlNQlD3KlehoRMlHBdsOfa93J4t0d
 zy6SP6YLF3PYiOM4RRha/i3lAw5xo3TGmXbWFVllzcZYw23zeI861wL3pX/1ohndtgtG
 poHrb38Q0vXYyJF5c5X1QcQw/ZkV23/kNzzrunkecgpsJXlifh3UdCthiWvryw1V0E/F
 sVDD4bymnBTKT+A85g5CSVFxFPU7I/Khyt/PHtZ9AaTxDzGKbWlxLxYvrRTg/E7HeHTm zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y3shms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:28:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGOaAn033391;
        Fri, 11 Aug 2023 17:28:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvamm6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPb9v262L1+3frAET8VNd9QRDRsT40Lzqr+IKBrP1RGhGv+cARivJBb6pbuCF0V30Pfd+YQfdOjA9UPzP3URcecjkk9pQUxlRiEv+JENX9FPL3GDFDrjhXox/LtrH7N+j5bUv6rlpIETXWBnMAzhkHsiFh9YPaw5JWJu1o5eVjB6EJxuYGyjJOHhtuUbtiDP7r2rDlnB2+R3CiQkbTu6OfkjoNgeZnIzzlRP3vAEJHfGXb3JdLi/y5MqgQ/k/MA5vrxVj7Bf5F+1+we2SNwbAs3hFt0PEtdoLCjlHv+xtGGts39vdag5kGzAZQAcG5xSA4D3bOO1udjaHe/TB4wD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVi2d176fTDfknkkhiOEuMqH/u/yKYYNHfZ9/8aRMP4=;
 b=mtrJSSLs/PYr2oyQKZFVElrAe3iR2hcb8l0R/zxtqWilVLmTXQ/Pl6m6OSSniBv9Vb3i9+dl6hStuiEOlOvUQ/0V13gdgnHwERZNGiuitGQgcSE7jRrMPSLnseQMR56aJl+QgqDALV9fdGeLiqGKZVkE+xxfX6MQh4U1zu1m4JdprfNoE3WJqzbqzMC+xr8T3K/8o0ZMCLemxjoUJlMHgA0pLZtIXIVQ5P7dobDIZYDQqY+iFXSIPH8nzhFuxf3rpQySoBb+7HEjR7f1XOmVZ99gpvyTxcxqLYqQKZtvLg55Hhsz9AZInhWCbxBvUvaCPh1Q1jkRLgwyLUkJF3ssgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVi2d176fTDfknkkhiOEuMqH/u/yKYYNHfZ9/8aRMP4=;
 b=H1+Phz2hRiqqk4TFYU9M7zTdGyUPB3nQzsqej7kDzeCnRALAc6h4bE2Xk/Y/RTdlGSv0i57brR0vEKUKBV0bawVYE76tLZuGLrdwKI8/P8xdF3c4d5Nyl3ad8pnXnI+UjAVZrfPpLhoSiBAfOzbfaC7m+3VGJ2NgpnEbTItpGoo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:28:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Fri, 11 Aug 2023
 17:28:25 +0000
Date:   Fri, 11 Aug 2023 13:28:21 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, corbet@lwn.net,
        akpm@linux-foundation.org, michael.christie@oracle.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, avagin@gmail.com, surenb@google.com,
        brauner@kernel.org
Subject: Re: [PATCH 03/11] maple_tree: Add some helper functions
Message-ID: <20230811172821.d5kmts2j47kzjvg5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, corbet@lwn.net,
        akpm@linux-foundation.org, michael.christie@oracle.com,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, avagin@gmail.com, surenb@google.com,
        brauner@kernel.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-4-zhangpeng.00@bytedance.com>
 <20230726150252.x56owgz3ikujzicu@revolver>
 <ZME23DS/Elz2XPey@casper.infradead.org>
 <ab4422ae-f923-1424-bb10-c345de059f3f@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ab4422ae-f923-1424-bb10-c345de059f3f@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa27372-6519-4ac6-4a98-08db9a905e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXCTAVEezorvqT0ydjf8YJDc0pk+DkMm5b5BuMC7Fo77Iah8z0APpM4Ya1TtpEh9POlIJuMx8EoqEExFKUoyj/QM7Z4FuG4QhK7JT2WdUx6tJNKapxnl0Lmq4TTAfNP66NE6hKPklaNaNIuSy243w+zGhnZ9ygsPshlKCR8DywZQDJ60UoAaeRQK1RizID6lDUcHQqMtrMt+6YEuRhkVk/UszTSfYnT9fCoIBjrXE7Fpzb/Ad/uvAVzL0qiGgtLkoBvphayA3yFEi0StL+7HkyL4QaPfZd9lXhsve5mY1YCyLxZS3LLTvq1RJnznrFvTnWjEABBen6/FKXRqVQxm7IgThB1DOTjFzFFassre6aXzwWhEhfE55tc9mkVmbh0GtxwGV4uHXxpLq3Uifig1Ubiskf76Ey432xBnm82OZ1jnuV6NQ4cJyAWF3XqqIb3vRHxculdBFu5qoohGmld7C7S7sz1b2qXG0zG4e+5Zbg2/UDjKhgQjv/oGvTb2+Ik+q+97rfDdLstrtadU05beVuHXBS/kh3fzs/yPklns0J1Do96oOT1AEJbXRqu7nldS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(186006)(1800799006)(6916009)(316002)(66946007)(6512007)(4326008)(66556008)(66476007)(8936002)(8676002)(7416002)(5660300002)(6486002)(6666004)(83380400001)(2906002)(478600001)(9686003)(41300700001)(38100700002)(33716001)(86362001)(1076003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2tGQlNFUDJjbDMyWUZXc2Z1Vkl6TWRxWnd2QU5oc1Njd0JsbW04VjUvRmlS?=
 =?utf-8?B?NlAwckw3TCtWS20xZExiNzlTV2tnMVc4cyt4S2hSTGZmZEFoSW1oSjJ6bExp?=
 =?utf-8?B?U293bXlVUS96VUp2LzdNSit5SWFwbjZ2ZUxnQ2pxcllGOGxpRFh5M1I1R0FK?=
 =?utf-8?B?MVVaczdQYWtlZFdzYS9BUk9tSjNNRlF0T3NKMmRDK281aUlYSDVGYTZ2VU5m?=
 =?utf-8?B?RzhZUUFLNW9Oa0hGMEk0RjNseWkxZzMyMktWVEpOMW9kdGtHWnBZNGhDZ3NE?=
 =?utf-8?B?UEltcjRsZ0R1RTRHWHJ4UU4wenBKOUZ1dXRnTDdrcS82eUpJVmFBakJ6Nmhk?=
 =?utf-8?B?N1JBVkpEa00zZXY0TngzSTB2VUgxRjdxMmJRbUhnWW4ydFNCelc0djJyQnJx?=
 =?utf-8?B?WmpjN21uNXNidUpSV1BXa1V5a2RUZ3dZREI1aW1sSlkyT0RLdnlYMVhmak1Y?=
 =?utf-8?B?SjIvRXFaNXFlaHozNXA4V29tWFBpODJ6SElkSzZCc0xta2FTV2ZJTy9KTHNU?=
 =?utf-8?B?cEEzdS9XTmVnck0yeE9Zb0hCT2x5bFIvSU1scTZnZS9sYXNBZ010cXNTK3Ex?=
 =?utf-8?B?WE94NHlESVgxcjVEazExSWNCZGJsNG9zS0dwejJYd3M2MzAxNUNGNDhuSHMx?=
 =?utf-8?B?VlhSb0RTc1BaeEJ3YVk3Q28raXJ6c0lCM0h6cG05SUkyK3BNZnhMcXd5WWw4?=
 =?utf-8?B?V0pSank1WGxwaHgrNHc4TEtGeldEa2FXdnhCUFd2dWM1RXBRT05SZCs0aGFl?=
 =?utf-8?B?LzkzRTh0RW11UWNQZWRXWWJmTVlTUnRJWUtXbVFtWTdsNlFCalBQbDIwcU9Z?=
 =?utf-8?B?dzBJMnlnM2tacTB5dFhYRndTYWRGQlRiUHFMSmc2UFcyNXB1c01RbEVaQkpV?=
 =?utf-8?B?ZWpDaXNGNjBjOVpTSmdoYWJmVktlYXFTNy81UDVDL0xRRWo5M0R2d25sOHZ6?=
 =?utf-8?B?b0xMYVhCOUZSUGRSKzc3WTBoT09pa1FMMUJaNTZDOFFFelE1T21temRlQzZW?=
 =?utf-8?B?NzRhVkNQdSsrOUQ1TlF1Z0pvVzNqdFExTWV1MG53aFZydFVPNmVuVTh0NHZT?=
 =?utf-8?B?OHNGWHRKdU9hckRDVDJtbDJ4M05tUGd1cXRBanlxM1FaekdmemtOMENham9T?=
 =?utf-8?B?aGxHRldFRWwzRTJ5VXdrZ3MwdHJUYnE2b1k4NmRqWWJRTmpLUnJ6SVBsK3Ay?=
 =?utf-8?B?VVE4VEhnd1ZzNkhUZVhFVzV2bXliUkJvc05NWHpSS3Q5NWplY2FXanF0ZEs4?=
 =?utf-8?B?NCtFSUJHK2t6TGlBNzFuUWNTWGZlNk1NL2NXSU5OVHBObjU1aTZla3ZmVGU3?=
 =?utf-8?B?MHQ0N3BEMXY0bTBSbVBYUVZxYXlxWS92WW51NmhlTVk5TnhycGNqYUxCaVNl?=
 =?utf-8?B?aXhZU1l6Q3ZqTFIxbi9tQTBRd0R3ZW81dm42TDRDUEdwd1BPM0h0MDBNeU94?=
 =?utf-8?B?NVVYK25BOHQrcDNoRDlxdU5ZSVJtem1nZUx2WTNJNnR1aFJnOHRzWEpIcGRG?=
 =?utf-8?B?bTF2M1B0K1lKR0pPNHRzL0FIdUUrSi9wajdKcjhTZnRXamxvZ1Z5Tmc3bVhW?=
 =?utf-8?B?QjUybTU2bFlvZnJqaHlSWmI1WGFyTi81a3hXT0JteXEzbG1XVW93TjhrbS9u?=
 =?utf-8?B?cXo2SFYrcXh5QVdYSGJqaVMxU1JGS1ZiSnZQeExTTnRpSVJzYlcweGtKL2Q2?=
 =?utf-8?B?NlZCY21uckFTc2UxRDJoZGd3WkZlZmNJdTdjMTRHSExFKzZjbDM5aEZ2emdh?=
 =?utf-8?B?OU0wK3NtOEYzcHFPdGlFMi9qVnlLdWtjWk9EbjVVei9xYnlFQkNvZ2RSS3Nj?=
 =?utf-8?B?RlZNWUtudFpHWVJHWDMxOGlrNlc4ZmczanRRRWhRU3lwWlJLZmd5MGV2S2pV?=
 =?utf-8?B?U004QzNLdmlhQVZtQ1VmWnltWUVCK0o5b3FFdEFhdkhLWkFiZFk0dlJRU3hT?=
 =?utf-8?B?OHRqdi8yaE1HQUU1ZmE2UDRxZWZIc0tTQktoYU5sSTNCTFFkWThQYVFCcGdJ?=
 =?utf-8?B?Wk5jOVRNTjJnT0NBK1JKQjN3c05rSVU4b1dVK0N1Y2lNUnNMZzZ6Wm9vMjBx?=
 =?utf-8?B?UVh6L0pheSsvYzFPSU5IaFkzbXk0NWEyTlQ2YUxGbGUzM1NJZVBmODNacXNV?=
 =?utf-8?B?QVFPUFRCREcrTkdjSWdQMXpxZDg2cTQybklneXVKM2ZYcHdqVUo0eWFaOFlJ?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cGY5ZXRibERvaVVwcEFJcWw3ZDJwYmxyNDJGSVduOHRybDRhZ0NoTnB5WVVH?=
 =?utf-8?B?ZXdNYmcxLzJuUWlHbmNQYXNGV3FhME1iS0VGZEtrNlAwZlRpYm0vY3A1Vy9q?=
 =?utf-8?B?SkViYWtSMWhSUnV1RXY2SGlvTFVqa1VCVVRGRTE4ODZsZVpUWHVrYm5ERW1S?=
 =?utf-8?B?VmFwTU5telJrZzBiMEdQRlQ3TkZYam1RNjdlSzhVZ0tFOHgySFEwQlJNNWdT?=
 =?utf-8?B?NWRkK2pqV1Z3MTcwZVc4N1FpTFZZRWVkMjQ3NUJDRjBUdDFsM1FqY0ZiTGhC?=
 =?utf-8?B?cjRkVlp1NFoyU1ZzVGF4UnNZWWh2SUtGMkRJR1R0cDNQajRzcXNOcmZoNkVU?=
 =?utf-8?B?anV5VzVwd04wcGNkRmU0UW1OQysreHFycGpjZ3BFbWpXY2xyVGZYTVNaSncy?=
 =?utf-8?B?RWZLUmg5WkZzZU5QUGRLblJ0ajVSeWUyQVFxcFAzWGw0NEdvVE9Rbko4Yjg5?=
 =?utf-8?B?aVdMSWQzUVQvL1h5UjZpNHJsVzV0MFA1RitJUEtRYmRRWGhidGhLN01oVGVI?=
 =?utf-8?B?MllmellSSU9UNzh1Wk84N1NVVnh5WlZ5RFFCcGRNYUxJNW1QeWRUV1EvQ1Rh?=
 =?utf-8?B?YUpYMzFkWk9IeDdTays3bUo5MGIzVnBMa21mV3RyWnBZaDk4OVlxcGl1WEVi?=
 =?utf-8?B?RDZpWHNXdXQ5aTdPQW04aWYxbE44R1VlWWZkQldPY3pJSU1MSGN2MlhIejVw?=
 =?utf-8?B?dG8zamxRUXBaNTNRMUxmTUZELzFyb3F3RUNHRFpzVUZoRXM5eE1IbzFMaXNU?=
 =?utf-8?B?dFMveWQzRGZRS3BDZ25nRm1ldkE3R2RPS3E2UUxpS3RWNWJ5b3ZkS3p6WUNL?=
 =?utf-8?B?NlUxQ2drRG1CQVNQZGo3c2RyOFAxcUpIaHRTVFVzUDNlYTYxZVhWZ0M0cXVX?=
 =?utf-8?B?ZldaQlZpeWhQRkgyTHVWV01mc0JuaEtrb1hlWndJMENTUm5lMWtKSklsaisz?=
 =?utf-8?B?UU9ibjVhYWZZMmlMR0dMSUhYbjRUT1NkcytZVWlmQm1BKzFodGJ5NUxIQzFG?=
 =?utf-8?B?L3FtcUlZZlhyazhDbmtGa0t5eXJ1WVVZUnRBVm5zVFNsZEN3OVUyMU5UU29G?=
 =?utf-8?B?KzAxcVFhYlk1ZU1xQ25IMzVOVVk5UVVUZFNTM2tkd3BBcXM3WitZbmM0bjNr?=
 =?utf-8?B?NEFNZUNPZERIVGRCSUU2WlpwK1pCTEt3MytuVUthaSs2T0tobk9FWWpPT2Iy?=
 =?utf-8?B?VEVGT1Nvc3FiK1RvQ1pMWFRTSmp4N1lScDJYUGV3VXF5VEorZmVONUpFcU5C?=
 =?utf-8?B?YzBkVXl5T1daM2JLdWxERGVCeVVvRi80bVlhdGlpTkFiYVA2SFRYdTBqT0R3?=
 =?utf-8?B?MHVrTEtZczliVVd6Z3BTNElVYUNldElUYXNQdmJDZmlGWjNIczlialRGd2Rh?=
 =?utf-8?B?NUtjQ2ZLSW9aS0NjZTY4ZXV3S013cmtEb1gwMndoOGhDYmpLNzB5bWR0NU11?=
 =?utf-8?Q?vkpsCJdO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa27372-6519-4ac6-4a98-08db9a905e64
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:28:25.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW9lM4D91CuHRZW5mSkvccjPIXDMe4R591vY4qHp37UD6PlW9Ntpi0I2h5CdIs1x7BEBsxJDWjYE80um070hYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110160
X-Proofpoint-GUID: xVoefk-zByurejQCDnMjM4Df0uf6ShUX
X-Proofpoint-ORIG-GUID: xVoefk-zByurejQCDnMjM4Df0uf6ShUX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230731 07:45]:
>=20
>=20
> =E5=9C=A8 2023/7/26 23:08, Matthew Wilcox =E5=86=99=E9=81=93:
> > On Wed, Jul 26, 2023 at 11:02:52AM -0400, Liam R. Howlett wrote:
> > > * Peng Zhang <zhangpeng.00@bytedance.com> [230726 04:10]:
> > > >   static inline
> > > > -enum maple_type mas_parent_type(struct ma_state *mas, struct maple=
_enode *enode)
> > > > +enum maple_type ma_parent_type(struct maple_tree *mt, struct maple=
_node *node)
> > >=20
> > > I was trying to keep ma_* prefix to mean the first argument is
> > > maple_node and mt_* to mean maple_tree.  I wasn't entirely successful
> > > with this and I do see why you want to use ma_, but maybe reverse the
> > > arguments here?
> >=20
> > I think your first idea is better.  Usually we prefer to order the
> > arguments by "containing thing" to "contained thing".  So always use
> > (struct address_space *, struct folio *), for example.  Or (struct
> > mm_struct *, struct vm_area_struct *).
> There are disagreements here, so how to decide? But I don't know if the
> new version still has this helper.

Please keep the maple tree as the first argument and use:
mt_parent_type as the name.. if you still need it.

