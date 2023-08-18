Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6746C78100D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378516AbjHRQOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378540AbjHRQOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:14:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DD73C04;
        Fri, 18 Aug 2023 09:14:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFntC0027814;
        Fri, 18 Aug 2023 16:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=lAdfZHK0luXrpRJpAu1bLSpyyWIhZTgIbkBhFfOD2n0=;
 b=a0GNaYjcSibFrOOErXFAWBfeYs9DCnHP5W9DXsZ6531+Kq+D008S3COCDg+u2DiRxLlu
 DZz76XN+CNGoZXJzhyZFJMzABjvWTBcHp9HNK4FDqXfxwHx8SLFsqxLaxq3mc20JcrQX
 l+3aO0pU+YET4q7NCpNnZwPjzRTTfdUdRwsdjYveMuYMwUOPoNmm03gXpPbUYXrsZpEm
 L3I4pqf20/4Cgq+SUZiWVttsGrsPvzPTRqoM4CRESc07xa6AEYx61/FFB2zF1m2dWyxh
 IPz84Q2NP5Tyh9g9wTtLW/NhGz+3BbLY8JQ+nBE9DoW5IyDsPZ6YOdWnxtIfGpYs5wPx Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349m8bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 16:14:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IF3f6D040286;
        Fri, 18 Aug 2023 16:14:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0v2gk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 16:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH2SfYsXPL1VR7B1qMgC6AG1vjRkORFQlbqD+p/3dp+V/PSA8NcvAYkxdT84sSZz7MeDbMpdatjyK9J5CVyACmVFYm+mz+/ZWCOC92pn3rsECKVOaslWtjvM56kzzZTD79azS+yOHPVlKaUZX017o0LTTfUnu6rgNQYsyu6F0i8xLmJVewMc7c5txHo6vwsyT6Eg6h39z57FvjU1D3i0knjJQTjvA2C+1S2TbF1Lv21QvJ0XTn9Xexjl+2pwJk3wUa05yT9k5A3EU2oJYnfhqL1q9ymBWOorH6XYlW9jUUDPELD+cooj0OZcDMSMiWz7HYwNRVARpOlrLQP0aAT++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAdfZHK0luXrpRJpAu1bLSpyyWIhZTgIbkBhFfOD2n0=;
 b=CXj5xEA25k0POM9o34KjvIfe8SHBsgM2wVLtS4RCKttBbBrg/tRUUyc+c7QdPPKggJoENKhFX0uOPPxwOBPahJ5BvMXNnRPSdSVbikCVHp+oAeHFii8FN5BB6dx0S6LkM4XJi0lcTV/8fBjC4SY49gQya9hUf+af/wdx6yEpLixeEPijsbV4APd8LVKiBNcgdDoRf0rPJKPsDo2gSW6oDW4LBSXRA+IvEVAJzpOwALnDR+atDyzDp1xjPVMhGAgoB6h91qG57Y71MjRYW9fKbchz2UUT0kzFxqvZLbShyKq+3eWHFRZKkTcNnH9Is3GNd5xaqtzR0QkaIU222NPuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAdfZHK0luXrpRJpAu1bLSpyyWIhZTgIbkBhFfOD2n0=;
 b=y4m8SwprxF1iqE5sH9Hzza2kzl7vDVa73fMXf1YIXBy1t5Oqvzawc7FUcVHyGPRK5lBTzo0u7LqpfBs+uhSNM195HrIUsQtz3iICEZ8sJ2oEK/k96aYqQb+ElHToafvvMs1I7DTVSVLbMkiOM8xWWSYUkDp+tDF4oqmQ26UUUvc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:13:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:13:42 +0000
Date:   Fri, 18 Aug 2023 12:13:39 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     willy@infradead.org, michael.christie@oracle.com,
        surenb@google.com, npiggin@gmail.com, corbet@lwn.net,
        mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org,
        peterz@infradead.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 04/11] maple_tree: Introduce interfaces __mt_dup() and
 mt_dup()
Message-ID: <20230818161339.tpjcxs35xxug6f2d@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, willy@infradead.org,
        michael.christie@oracle.com, surenb@google.com, npiggin@gmail.com,
        corbet@lwn.net, mathieu.desnoyers@efficios.com, avagin@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, brauner@kernel.org, peterz@infradead.org,
        maple-tree@lists.infradead.org
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
 <20230726080916.17454-5-zhangpeng.00@bytedance.com>
 <20230726160354.konsgq6hidj7gr5u@revolver>
 <beaab8b4-180c-017d-bd8d-8766196f302a@bytedance.com>
 <20230731162714.4x3lzymuyvu2mter@revolver>
 <3f4e73cc-1a98-95a8-9ab2-47797d236585@bytedance.com>
 <20230816183029.5rpkbgp2umebrjh5@revolver>
 <6b6d7ef1-75e4-68a3-1662-82ee19334567@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6b6d7ef1-75e4-68a3-1662-82ee19334567@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN2PR10MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: e68dcf5e-ea47-4239-b40e-08dba006175a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oCRlw0Nm9DtcRMKYVyJfJy8ir0njfPGiNTzscyXiH9rkRc1p7jiaaFukd2DeE6JzJgFNSpEaws4p1ATjkGbtMm1FEMOswX4aHCYXzyOp1GHDOqSTqrj8/DxSkhDqUpFPXZ46aW4nrevWM2r6K4HEdt4D81vixFUHjbbv8bBd/qOE+lCc+qeZTxltFry/o0JKDXrA73ApRixh4oGyce20YoFwAvb1j3G/F0AZjUDH4j0uF+YsHPAlGxrf1vcaqvSPmkZyxDRapG8hJE224cO37GKnhIbdUjU5XxcTW+CYFYgI98l9YQavnQNn/rKI7Ca6bC+418x2AFzobgnM1HL8oslgbH49eePQDannv9sl5LkFz8fyHht8p93IFZFF81+ahRmY3/gp3DM7xVP8Ep1Gkpi3QKtoBJ6TR6HSfIFI48QxKRDw8jSvUvG37mjrjh/JfClA4kRxfNOmS0nqhMYjxWa3v07+5R1Do1p4MJjKe80GwBwcT8QwLbcNUQDUOSJDc7ouBZ/GpaJNv5ZMUvas1nVSOi2XdzRR0LDyaWwOPrKWtU9WTHNeSxQqHCwA2hT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(5660300002)(41300700001)(2906002)(66476007)(66556008)(316002)(6916009)(66946007)(7416002)(8676002)(4326008)(8936002)(478600001)(86362001)(6666004)(6486002)(9686003)(38100700002)(6506007)(6512007)(33716001)(83380400001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRhZHJKWittVUJBTEViaDN4a0pZVnNJQlkyWTVNNjE2ZXJ2L1FlbXJDRnBx?=
 =?utf-8?B?YjY0R2NsYXdLem50NVFEc01mbVJCdkswTURUK2ptbzcvUlIzQTdZR2l2eFo5?=
 =?utf-8?B?NGxyK1VtdHRpTWc1RXFtRW51czN2NkFkK3VvSFkzQWFIRGZQZEpLMnkwejFV?=
 =?utf-8?B?bmh0VUg3UzQ0UHk5d3Nrem5GbDUwWmRWdWJIMHdTZGxqQjR1SjR2MUViREJD?=
 =?utf-8?B?dkpLVEpTY1dtV0RHVFFhWVpZNXBucFdtL01rOUNxR1pUV21YWFFmQWJCQXM2?=
 =?utf-8?B?Z3A2cTZ4TTJMa1pmZlJqR0orbitFQ3h6Mi9wU2tQdUZ5K0pvNVBEOG9ramhj?=
 =?utf-8?B?bGl0a1cweGhuTFV6YmdoMzRqVWhtQ3NBSXQwTGxIM0NaNXFFeWZPTzlGc0R1?=
 =?utf-8?B?aUIrN2FoM2dlV092dVB3UG0zbGRZVE8zTGVGUFFzVHR0cFZ6dnNEVVB4MU9t?=
 =?utf-8?B?WG5FeHA5UlRBbjI3VHlIQ20ybEIvRlE5dDBhRlNQMWJyV1VvbWJteUhMNnl3?=
 =?utf-8?B?TzlSVFdvSGg3ekV3anIzR1M4ckNNSVRLKzlsNEd1Z0YrYzltdFRUbXIzU3d4?=
 =?utf-8?B?ZjJSZHR3QkdKZDdoZEtqZ084Tk1hVmJhN1VOZ1ovaGF4N0wzQ1pxbmhqcG5U?=
 =?utf-8?B?REE2bWxlQm42T3dXSU5ocWl3NW5KWlVFWkNLUjdmMVExWGw5MjlUV1cxVHFk?=
 =?utf-8?B?NERjRU5ULytoMDAzMXVDRXUwbkJwdkZWQ3JmeUNZUmhlWU5uY0FtWWNmMzlk?=
 =?utf-8?B?d2pqUDdwTDBhOW51ZFpOSER2SnlhSHhZWHRCcU5sL2M1QWpZM0dqMGNnaE51?=
 =?utf-8?B?UERkNVZaWnJQRjlrTnNFYVRseThKaUFMekM2bDIveXN3bDdFZi84UUJOU241?=
 =?utf-8?B?cDhpUGdTRkNPRUpOcis4Q1RPSWZWWVZVRWVhV2RCYXNOT09IeUp2cWxrQ3Uy?=
 =?utf-8?B?OWZjUXdrUXlFNURVRElrQy9PNytJNHoxbnA3OEhCbGRoZzZqRVBQTHZSYXNI?=
 =?utf-8?B?M2JqRmFtTkcvOS9PMk80cDQzTGJpR2hWYU5NT0hzS2ZWalB2RitwN3RiNmkv?=
 =?utf-8?B?ZWlxSVVVWkMzSU5tVHNpR09mUnBNbUtKVGV4ZnR6TzVqUS9aNjRzVk80SGpH?=
 =?utf-8?B?UjB4cmkrcGRMdDQxUG5HeS9QRm42OUdya3RNMUtOUjF2T2tzRVdDSHdlNGEx?=
 =?utf-8?B?UVpWUlpNcE5qV2VKeUlOZFlUNDZqem4vSGRXYjFWVTBsVDJlTWNtWTFvc25C?=
 =?utf-8?B?RmtqODlWTXNnalBLYWdnSlRQT2o2SkFOR0N0YmZLUHlXRnhXaUFOcTVkT1g4?=
 =?utf-8?B?MzhwRThyS1MvMDRKeC96MDFqUDd6eFVneHVtMFd1L2VZZDhmaU9mdGR1TWlq?=
 =?utf-8?B?ZjJ2MnZDaXJMVW0xVGh1MmRZcnJkNFF6Q21ZeGFQT24wMWhpQ0N0bUFUMUps?=
 =?utf-8?B?c1JIbmtCRlVQL3FuTlJoeVJKY2dBOFlNZDJBb2ZSSVMzZnVvaW9pcnJMRGdX?=
 =?utf-8?B?UzVMelBvUGcwMjAvWlpqS3ZwNnYrYkZITHJiVVVIT3J1KzM4UG1TcDBFdXZZ?=
 =?utf-8?B?UWIwT3E1Q3lQVW5neGROckt6Z0ZjQ0pTdjZDT1c2K0NBcjZsTXVFMXB0Rk5u?=
 =?utf-8?B?UWZ4dkR2cWZMd2tXci84UGVkc3ZobWRrWWZ1TTVGZWpuYThobUh0TnVKWlc2?=
 =?utf-8?B?bld4dUtJV1Qzb3VxcklJNGJmSDdPZHpJRlZuQnBuL0dCS1ZLVmZqT3VZSkQy?=
 =?utf-8?B?Q0pHZWR1YVpDVUJ0eHNMQzZud3NnaU1HQmNiZjJ1cnFMSmxURmlJRXJWWCtt?=
 =?utf-8?B?VmdBSG10WE1qUlVIVFNuTEdFcys5LzZGMEt4eTF5Nkh1c0JPdGtUOGtobURo?=
 =?utf-8?B?N1kvTERUUWpSeUpNM2JxN3QzR2E2bTFBTFRYWjVuSkNScTRiMlVzRXNYUVl3?=
 =?utf-8?B?d05rQ1ZzZ2EzSGY0TXM3WXNuWkprR3VFdk1CSlNDSXZwZS9JMzF1cmRLOGYx?=
 =?utf-8?B?dDFiTEhaK25uVlFEenMwV09xdlI5ZG1LVnVnVC9CVllEaldxb1FZZEZ1M0cw?=
 =?utf-8?B?SEQ3RHVTdmtUM2N5T2gxRjhwU0NiODUvOGJnUmtyVUMzSndyVWZMZldCZVAy?=
 =?utf-8?B?NEd0NDV4Y1loMXV3SnVlY0oxQm90dUJGb1ZDM0s3YWwzYWZORTNsaGV5dFk1?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RStFY0N2WCtXUkpwT0JtRWVaLytkaFlxc3NpcUtvVkZYd0I3Q3k4TXRWUGRq?=
 =?utf-8?B?cklKTWRCYkcxSTFGdnRnV1lIQlN5ZjZuVFExOHRPbDIvRUVBSGp2MmtyK0dj?=
 =?utf-8?B?YUVoYWJHWXlibnhsQ0tGZlF2VFdla3ozVHlLWGFlc0pFOFVpTzBpK1FWYkJn?=
 =?utf-8?B?VUJYRUczQmo5a2ozRDFUa3ZRQWozS1BxUE5GR3lhWmEwR3h4RkN0b1ZaWHBw?=
 =?utf-8?B?dTlYQ3NIck9pRWNXaGM5ZDhHUStOc1NZT0twWTVtU0c2Wk9HMjFVSGs4YVow?=
 =?utf-8?B?SjZwSCs0K3VLR1lTRlFjNFduUG8vTk8yVTBtTkZSYWIzcG9MMkluYmxuUmNn?=
 =?utf-8?B?SU5pRWhxQTlUS3dmLzUrZ01OZzErQWVJQndGVVJSMTVvQ1hxbXR0TTZyZHZD?=
 =?utf-8?B?MFVtbEtNZ3NxaFFQeFRKV0VEMklNY2t0TUNKQjZuUEZlZXdvUk1wZ3ZleVN5?=
 =?utf-8?B?VzJWa0JaL0FTd2l5dElJS0ZvbGpmY3p4c1k5dnRFSE9FaUlMQko2MmlvYjdZ?=
 =?utf-8?B?RksyMXl5enNNZjUvajM4YjBKcXp5SnUwNFUwYytTYjRnVVFWRml4RjU4UGdT?=
 =?utf-8?B?RmFRbU9HMGJ5YmFPZHdEeVRNeVpabGFYU0kzS0J4K0wwSkRQaUFxdURKNmRE?=
 =?utf-8?B?dDZGNXFTK3luMGRlT2dZZ3BBLzBUdmZwcEMrYWFlY2JyVzZrM2NOUEx0V0pi?=
 =?utf-8?B?MEtERUt0azNZRTU5UnltdHF1QzBCWlVGdFB6MlNJYlk5VlhxWGJjMEdWTHJJ?=
 =?utf-8?B?amgzL25mVzN6bFErcnRVYldnUnJTbjJYRDFOd0djVHhNV1g2YndrZ0lmOVl5?=
 =?utf-8?B?anZ5QmxYRlpWT0VRdlFJWlFyTWF3T0hLU0t3VlV0R1J5dFdKOTdlRXJhbkE3?=
 =?utf-8?B?ZzRGNkg1T0s3VGRNMmpoT3d3NjlVQ0UzWlU1S3ozVjg1dk1VaTJOZFpvQnFE?=
 =?utf-8?B?ektQSGJCSHNXRHB6R0h3OEErUUhBV29kUjZEN3phYjhmS01GUFFDWFZKMzhr?=
 =?utf-8?B?Vm1FWW5WcXZzQ3JibDFCckF6OGdNelo1UEpCeWpKTnd1bkVub3NJR2xEcEEv?=
 =?utf-8?B?dE9YZ0c5Vjg5M1gzKzFsdzdqcEJhcS8xSWUzdXVWSnVXZXRFUWZ3YWxHSXJ6?=
 =?utf-8?B?d2ZJQTY3NldVaDZEeFJQMUtsRk5JL1lFak11ZnZVQU1ZaktYdWV0VXhRcDd4?=
 =?utf-8?B?a2U5Uk9JZ1V3ZnE2WDNXOW5BcnlXRnNqcyt2eEZCeVZpMHZvK2dUcThtaFVI?=
 =?utf-8?B?c1BHVExkZ3BaaVZDSlJaaW1FZXltWjR4NGVFM3U0UkYzbDU1ZHRZQnZnLy96?=
 =?utf-8?B?bFpxWGNmcUEvR256YmQ0VldSUlgxWHo4SVd1WHkwbWhiWXE4cmtldjNKM05l?=
 =?utf-8?B?c3pxcjg3V0JEVWpLNjVybjFYSkNSczE4UE5Rd0xkRktuSzEyOG1nMTlxV0V2?=
 =?utf-8?B?Q0hvNTJHbVFnais3aHZFcDZ4ZWltV1dTdmFZM0FhdzdKWk5zTDBPdk1yVExt?=
 =?utf-8?Q?SMu8Bc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68dcf5e-ea47-4239-b40e-08dba006175a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:13:42.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jNc+aHTEQ+A0cEWBhWzRZwZIDfdJXcuE3WHySJvU2WIB6FjI2gwRoImqhdQl+nn4l4pxJwo5idVFNcTqRoq8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_20,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180149
X-Proofpoint-GUID: TMvd_twswVoNEiLea0SYWhOABY-9hA_Z
X-Proofpoint-ORIG-GUID: TMvd_twswVoNEiLea0SYWhOABY-9hA_Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230818 07:54]:
>=20
>=20
> =E5=9C=A8 2023/8/17 02:30, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230816 09:42]:
> > >=20
> > >=20
> > ...
> >=20
> > > > > > > +/**
> > > > > > > + * __mt_dup(): Duplicate a maple tree
> > > > > > > + * @mt: The source maple tree
> > > > > > > + * @new: The new maple tree
> > > > > > > + * @gfp: The GFP_FLAGS to use for allocations
> > > > > > > + *
> > > > > > > + * This function duplicates a maple tree using a faster meth=
od than traversing
> > > > > > > + * the source tree and inserting entries into the new tree o=
ne by one. The user
> > > > > > > + * needs to lock the source tree manually. Before calling th=
is function, @new
> > > > > > > + * must be an empty tree or an uninitialized tree. If @mt us=
es an external lock,
> > > > > > > + * we may also need to manually set @new's external lock usi=
ng
> > > > > > > + * mt_set_external_lock().
> > > > > > > + *
> > > > > > > + * Return: 0 on success, -ENOMEM if memory could not be allo=
cated.
> > > > > > > + */
> > > > > > > +int __mt_dup(struct maple_tree *mt, struct maple_tree *new, =
gfp_t gfp)
> > > > > >=20
> > > > > > We use mas_ for things that won't handle the locking and pass i=
n a maple
> > > > > > state.  Considering the leaves need to be altered once this is =
returned,
> > > > > > I would expect passing in a maple state should be feasible?
> > > > > But we don't really need mas here. What do you think the state of=
 mas
> > > > > should be when this function returns? Make it point to the first =
entry,
> > > > > or the last entry?
> > > >=20
> > > > I would write it to point to the first element so that the call to
> > > > replace the first element can just do that without an extra walk an=
d
> > > > document the maple state end point.
> > > Unfortunately, this does not seem to be convenient. Users usually use
> > > mas_for_each() to replace elements. If we set mas to the first elemen=
t,
> > > the first call to mas_find() in mas_for_each() will get the next
> > > element.
> >=20
> > This sounds like the need for another iterator specifically for
> > duplicating.
> >=20
> > >=20
> > > There may also be other scenarios where the user does not necessarily
> > > have to replace every element.
> >=20
> > Do you mean a limit or elements that need to be skipped?  We could have
> > a limit on the iteration.
> >=20
> > >=20
> > > Finally, getting the first element in __mt_dup() requires an addition=
al
> > > check to check whether the first element has already been recorded. S=
uch
> > > a check will be performed at each leaf node, which is unnecessary
> > > overhead.
> > >=20
> > > Of course, the first reason is the main reason, which prevents us fro=
m
> > > using mas_for_each(). So I don't want to record the first element.
> >=20
> >=20
> > I don't like the interface because it can easily be misunderstood and
> > used incorrectly.  I don't know how to make a cleaner interface, but
> > I've gone through a few thoughts:
> >=20
> > The first was hide _all of it_ in a new iterator:
> > mas_dup_each(old, new, old_entry) {
> > 	if (don't_dup(old_entry)) {
> > 		mas_erase(new);
> > 		continue;
> > 	}
> >=20
> > 	mas_dup_insert(new, new_entry);
> > }
> >=20
> > This iterator would check if mas_is_start(old) and dup the tree in that
> > event.  Leave the both new trees pointing to the first element and set
> > old_entry.  I don't know how to handle the failure in duplicating the
> > tree in this case - I guess we could return old_entry =3D NULL and chec=
k
> > if mas_is_err(old) after the loop.  Do you see a problem with this?
> This interface looks OK. But handling the failure case is tricky.

I think it's awkward, but not tricky; possibly error prone to users.  I
don't like this solution because of the error handling.  I'm just
stating some options I ruled out in hopes you see some way of improving
them.

Maybe we name the check something like mas_dup_complete(old, new) and
all it does is checks for an error?  It makes it obvious that it's
necessary but doesn't avoid people leaving it out.

> >=20
> >=20
> > The second idea was an init of the old tree.  This is closest to what y=
ou
> > have:
> >=20
> > if (mas_dup_init(old, new))
> > 	goto -ENOMEM;
> >=20
> > mas_dup_each(old, new) {
> > 	if (don't_dup(old_entry)) {
> > 		mas_erase(new);
> > 		continue;
> > 	}
> >=20
> > 	mas_dup_insert(new, new_entry);
> > }
> I think this interface could be better.
> >=20
> > This would duplicate the tree at the start and leave both pointing at
> > the first element so that mas_dup_each() could start on that element.
> > Each subsequent call would go to the next element in both maple states.
> Every element of the new tree is the same as the old tree, and we don't
> need to maintain the mas of the old tree. It is enough to maintain the
> mas of the new tree when traversing.

Okay, and using DFS means we can't stop one level before the leaves
during duplication since deletes may not function.

>=20
> > It sounds like you don't want this for performance reasons?  Although
> I mean I don't want to record the first element during duplicating. But
> we can get the first element after the duplicate completes. This can
> also still be within the implementation of the interface.
>=20
> > looking at mas_find() today, I think this could still work since we are
> > checking the maple state for a lot.
> Yes, mas_find() does a whole bunch of checks.
> >=20
> > Both ideas could be even faster than what you have if we handle the
> > special cases of mas_is_none()/mas_is_ptr() in a smarter way because we
> > don't need to be as worried about the entry point of the maple state as
> > much as we do with mas_find()/mas_for_each().  I mean, is it possible t=
o
> > get to a mas_is_none() or mas_is_ptr() on duplicating a tree?  How do w=
e
> > handle these users?
> The check for mas_is_none() or mas_is_ptr() in mas_find() is really not
> worth it if we hold the lock. There doesn't seem to be a good way around
> mas_is_ptr() since it needs to enter the loop once. mas_is_none() can be
> solved because it does not enter the loop, we can use it as a condition
> to enter the loop.

So do you think it is worth making a new iterator then?  One that
requires the write lock so some work can be avoided?

>=20
> Without using mas_find() to avoid the check inside, I have to figure out
> how I can handle mas_is_ptr() properly.
> >=20
> > Both ideas still suffer from someone saying "Gee, that {insert function
> > name here} is used in the forking code, so I can totally use that in my
> > code because that's how it work!"  and find out it works for the limite=
d
> > testing they do.  Then it fails later and the emails start flying.
> >=20
> >=20
> > I almost think we should do something like this on insert:
> >=20
> > void mas_dup_insert(old, new, new_entry) {
> > 	WARN_ON_ONCE(old =3D=3D new);
> > 	WARN_ON_ONCE(old->index !=3D new->index);
> > 	WARN_ON_ONCE(old->last !=3D new->last);
> > 	...
> > }
> Maintaining old mas doesn't feel worth it. If this we have to traverse
> the old tree one more time.

Maybe only when debug is enabled?  We should at least keep the first
check.

I'm not committed to this interface either.  Do you have an idea that
works better?

> >=20
> > This would at least _require_ someone to have two maple states and
> > hopefully think twice on using it where it should not be used.
> >=20
> > The bottom line is that this code is close to what we need to make
> > forking better, but I fear the misuse of the interface.
> >=20
> > Something else to think about:
> > In the work items for the Maple Tree, there is a plan to have an enum t=
o
> > specify the type of write that is going to happen.  The idea was for
> > mas_preallocate() to set this type of write so we can just go right to
> > the correct function.  We could use that here and set the maple state
> > write type to a direct replacement.
> This can be the next step. We can do without it for now.

Agreed, but your current replacement is very close to what we have for
direct replacement after all the checks in the current write path.

I'm wondering if we have an enum in the maple state to just go to that
store operation, then these two interfaces could share a lot of the
code.

But we should leave it for later, I was just pointing it out.

Thanks,
Liam
