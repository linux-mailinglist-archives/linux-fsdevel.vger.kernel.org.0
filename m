Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779E769FB12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 19:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjBVSh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 13:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVSh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:37:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57793E630
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 10:37:23 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MGTEvt030941;
        Wed, 22 Feb 2023 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dCAOtFnOrWC6T0D75/bnxoifoTXMFk4p/8CcU5rVDzw=;
 b=D/SO64jF35nIPsLJ1e5qQjywtPZvisi27sY6Ha5zddvGJm0mtUTR4A+/MG2pQ22jfcTn
 9I4gbdoN9Z5/H3XGpcSVlz4ki39WU4yI+tUMwuYfQCiiDfuRLifpBLC8WYylBFDHhpsO
 i5EflCGvpaD5yPhwP59Sz/tsXPv9v93/1THjLOOYoE+VwCRu9ieCGFCd7lRur73r3EW+
 QcZL04qTXFvUM75Dx2nkQthlCCYFgw7uQsGuHSHvfiERUeIQCG6eRGcskPQZHkwgjI3D
 KPFqYrV3l1GNZpz1BXnvI084z4+vUNIfP+cwSPMul0PwoA4s8VHusRf45o25EuPjFP16 QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcgs15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 18:37:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MHLu2W027291;
        Wed, 22 Feb 2023 18:37:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn476u9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 18:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO7+4NQefi6dvWyCsETj55VcIN1C4Kt8rBHFDL0l6gFFUjliPXaKquCZzT+NwVoaMWJcIlVgbR00VeFR3NEnuDtKKfPnLnr+1+v00eT7s8EfGeTPQf0AnrgyM+fEZm959F9fR8BoZeolCnrIkDgrdS83J1JhLOkE8gn2TTBbWwXiW3BfDx4I7ZdzUrWwp6WUXpTPskjjzEbTKb0F6zlrrL+5GQiicfopKZ1V+3SA1j9hN8Gh59NSyNr2l2oy7ywPp6aX16lRJzo0hnqXmFc5oBQrcPuKCZ/A7v10vOpkieaTzjwsMGgC7KRoRVxNm4YSsG5tP8dkZIV3tbZQWgFr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCAOtFnOrWC6T0D75/bnxoifoTXMFk4p/8CcU5rVDzw=;
 b=cb6OJP0YP7IRLy6jesZQKDM+cKp592JKS3W2R1woZq8nzXyX3aGHLc5XLRtzHjCjatMzZ9pcCgj9Vv1p16534mzmbQD36R0N/HFIdFV0KXCxyW0/1jWNowF2RNBqgP1AXnoIuxv2k/MEQQuTitA7K6dPvbxDUIFm/33BL/Y/q6ohFRRocEUYVUbLoxqVJq5X+b0iJD2rCOoZ5sCx47g3+zGXyeHpvWEz8Xsaejc0ZuPaPiR1NGFP8ZkY/FhqeqxLC6pIPWBL+zQ1okyTFL0vMqaWgSM0+v2zJfrSYrfDnFDm80rr0ZR8B6E67ypOW+EmZ4yT8ycU4v1PkOSkHA5btQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCAOtFnOrWC6T0D75/bnxoifoTXMFk4p/8CcU5rVDzw=;
 b=o6cOMWQi6NEWOQ6UtdsfkQt1K7hC2BrTgVZZG7gFOo1It4PoQO9iI2Pl2YjwgR3UWdVh3/F+NRQqgyBwz43+Ckz39Iq9cllP0HvthvltMQ5qoZmVJGZXPN12c5AmzklDUZt6MRzUf32bfCSmSqrT5ymLnT0UgujDK0RTEWrW93A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 18:36:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6134.017; Wed, 22 Feb 2023
 18:36:58 +0000
Date:   Wed, 22 Feb 2023 13:36:55 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Scalable Pagefaults
Message-ID: <20230222183655.swfsssw63m7z3ktq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <Y+/f9slIaK195fRX@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+/f9slIaK195fRX@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 9785f266-6ca6-4665-c64a-08db1503c7e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZoZq/jtOTsCe0ulgL/ZTsYuWpKeUKMMaMUijgvdAW6Qq63e+uaovizB7iKakIhwJOu3L19U85/KWClZbQEO+mxwsujk2w1Og/k0x3xUgZBJezj81+7h6527QpRGrObk2xNFAyNHSc+YMdoVAmTrHtXXthBVkvlAXkXafhH20JZEK6d62XDhrg+ICtl10NOHkHF8rYEW1sNikqOAK76spkltp9/1s6lWtjc1eMI0Lq+6ddJb//88Tzyh7eEgEw4sFWypBMDu2fldmf9zMIQJY+S/SrQ30kPVgQAKk4CWF2upHXyl0SkxDwxeiu5mL6+qcWlRrWw17mt/ObepuIzPQQoCw2SdfyiLrrY7+RjIl23nuxnc/cXXBVA9UiK1MeXpTFGFjLe1rOrpFmoMsap2GQKevVgcPKlaYy5w+nqGQUjaWoSWiQBSwt7Z++YKVI/VuHVnXyBexVI+SRRaaL1Yh1Kz8nulRE4uqre7o17vtrAakk2VoYtIj4kb2AKH6npVErvtedNT2R/8XF6tx1/ajXyOd04P7RpKk22VfTxcjB5VLR71UV/jNlrW340NV4Aa8YJ8+SXfrvMS4L6WVKoCPLuSS6OdTciGPxp9X5RNCsPtjAiXvHpMv0Ob3+O/nxFP1sWSNM/j84PWd/RG4mdhVa3S8zTeMDzNaBVsRwbOVAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199018)(83380400001)(1076003)(6666004)(6916009)(66556008)(316002)(26005)(9686003)(66946007)(66476007)(4326008)(478600001)(6506007)(8676002)(6512007)(186003)(33716001)(38100700002)(86362001)(5660300002)(41300700001)(2906002)(8936002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WU3py3TueMjZOeY5OkxSRN+yyvAuN67rx/zNO97Bz721dfsUWmZ1juL6UjAB?=
 =?us-ascii?Q?s1Srqf4LQ9cH/UxfFsCfpp5BjnB3R0lEPL305h7NP+kDfazgzB+RGAnVJFMi?=
 =?us-ascii?Q?XCZWkrAZjU+BucR+HsKBkxoODoGbtL8xc2tI3cidAOloIxRP1NHh1D7ZaRRe?=
 =?us-ascii?Q?7Uo7Ef1S7SeInOEQmxxopS6i4pTRQCnwFjcy2zP/n+RnZ7TzkHcxeX/KvpdJ?=
 =?us-ascii?Q?V1LPfldHmR/MVfJgclUQvV3OrP0DvUX9IUqzJj05Sn4nq8/bRaRCKieHv8oL?=
 =?us-ascii?Q?X3xdycLledS48XeZOEQ9OITzU85m5fa/aRM24auXbIsX9Tl5GJCn2vJTrbon?=
 =?us-ascii?Q?MjuJhycFL637gNSCBAVVsetCOGWFuJ8x/GGg8gni2ZuWXH9ea5ru4ChOrhUo?=
 =?us-ascii?Q?/Qe4JfeiZSvlyhDUP+FLYNC13zQypFNsdRK/88gIgIFcx5H9loKNnaW7HH32?=
 =?us-ascii?Q?twz100r3PnthQzR4gtcHM2OdXPffEIwKFtbLiQUq5odjVXATGPELSAylDP8r?=
 =?us-ascii?Q?0MwXJT40v+1fhV9KEq3mBisBcbxnc6EuPmDPFDbTh8GQpiglN5fbwXa7+Z2l?=
 =?us-ascii?Q?srxQ+9/AMXWgi4CnLuu5Dg12yWD1RW3T2g+cW6RVYb2F78Xd31sv1I7aB74Z?=
 =?us-ascii?Q?0f0W0NO5ooFVx+vo0XgACO3i+8bvAimzTn2+Got2LIdPsLBmtVGwiPamOUgS?=
 =?us-ascii?Q?O94MY03GS8P5QSgpNYh6I9BJsCwph/8Auq6XNviL7Q2VAIVv1i/bWKLTtCSn?=
 =?us-ascii?Q?NQiQf4snKNjamQJJcAS4w1t3VZQyP9FqJaQdz5ABD6iwCKpFmsqAOhPyCal1?=
 =?us-ascii?Q?jGXWa/7i+7LaITHUXme8Stw8mN+TXsekZryws1HkPl9OEgpBU2P9gbwSbLDo?=
 =?us-ascii?Q?HG+CTEfzu0S3dUDHBwwGXS+SOt/Gj3ZYSVWdRmMmYYaq6vFjhBTAN2P5nQj2?=
 =?us-ascii?Q?W/Dv4NPRWWy090cgJ2ErLWNKJf6oUKNMcWnjs1CNRZAYudsGdgf1F6Atp9cL?=
 =?us-ascii?Q?2Pq4nM9SuAyuxnu7fe/ZVLPHVcwOWczgL8tvTXuj3fkv2tjbaFK2XFetw2dL?=
 =?us-ascii?Q?GMohqy4biFjwaEAteulIgot2PzXgbcLojpkfUpfVfBtDpga3UjVn45T6c7zH?=
 =?us-ascii?Q?4O132B0yaMsoBzLP2V/vfNzCX5urziTdlY5mdjGlKZnLhRIHmV59iSGo6x0E?=
 =?us-ascii?Q?vrTs71Vn7MCnWI4adVaS1SvUcb3LVnfGSfaZHk9pPydtq1cRow55s4raWsK3?=
 =?us-ascii?Q?Ru9h3F64OLil96zVITieIhwAkvn3gUU5nKrsWcNRFFy8BgW+ITLJZaQLxVEJ?=
 =?us-ascii?Q?cmmY6hOc/Mo3t0IP5SRl2uISWEl8HOoSFcHgtdVuDlzDN5zmjyTVbfE8W1Zh?=
 =?us-ascii?Q?qyto27nc9nWsI7OM7PNW2LykXWTn/XWaHbLcR1/2yqF9YyO+Bcmkh95VN98u?=
 =?us-ascii?Q?3mlepK9Srhra7gRj3F7XelKffeVGCPQimZAIYjo3YonlwZxsuJRTlI1vUUPD?=
 =?us-ascii?Q?ez6JRcD1dfpFiyL2+QDigTxP/GgXrmQu8oB07Dj0pPecs6hCngjOr3VLVRgv?=
 =?us-ascii?Q?r2CU7qAy6WmvQDOyQvlYQ1YIVSkZ6NZvPLffC5DU93+gItO7y36C/C7rG45m?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wNZ6wZpyhicj4o0hDMNsiVT74BdSRRdUITY8vvSWq3G4Q89MkI1NoftU4XBkc+VZ31T+X1Pz+KKHhB3csB+78A2QnEFmtrP48ptSgYxH23DRzAn1XvBpP8QsXKtVR6VjR0DXHBt5EZofrAKtCnU42muoe9fwkI1AKuU6QXxDKD4wiJbmOdlC4bPnrVEhb0e/7Do4f4oCAIPZ3W1U22M4slhPQMTeINV9VtqsfPJ38aIDEXgA5qLil8CbyJB2RTQ5aw0guPs1tu5gUaP7f0reKZWNwZBNY8bYpYDA6tpfU9njGTSMG1BwC9j0iYFMX2BrD/LqATGg3Dqn4UY7i9DWW2lV+HBfp0Xci0Y3zF5K6+L1IEviuaa01ywUZx47K40pgPMZLLNex8IJdlTJFpGL/cNeEgcBM9MCIWlJtMiGsb98y0TZMsZAdEvIl527w67NxX8xa8gXTGsNGbt4/e+bcxiaDJI6uVH7JUMRn4ZL7mOQnnMgx+OamFXreMS8eJXsviRvWJpfJxTa/LaGD9aLdMTUMrZ74vv3jy8Yt+WiXZHurnxaLiwUIiV723dA3j/9hAKgolpf1AcpP5vCZYVjWL2FQRoc4zVaPHHQRDxKFa45xsSh6L1zDD/M65zcSjZLsWHjGnEfqIO4+nso6vFqAxtD8WyOFqcpR4vMzd0rtIgX7OlfUSX8JTCCO5OlosJUSQ+5pEUNQjnrShkRz24wk1D1GW+F8jxg2lCpIYcHD5uPy6Db1J4f02vBt42r6qyHhTtIiFdM+Ujy7e/zmjiVcFvBKBCshB/AlwN4xjI8LUJ8VPiX07b7c57LvSup4strRHLSQze9j9LFSQJO55mfD40Q57Bfn2Taj2kC9D6X3I87YrifCo6DCi+d+HR4dvXeIe4yYCwzQh3BaBcpdy78eQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9785f266-6ca6-4665-c64a-08db1503c7e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 18:36:58.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9C47LmG0G80UYxVB/g4K33qKNkVV/gcgslspo8NXxe4ThB4PUKuVkRgDvoGLRdAbnosDtkGm4Rq4bnXVqjRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_07,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=358 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220160
X-Proofpoint-GUID: kLHQEXVbb2AbDbRO2OpsxWYpXGYW_9re
X-Proofpoint-ORIG-GUID: kLHQEXVbb2AbDbRO2OpsxWYpXGYW_9re
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


* Matthew Wilcox <willy@infradead.org> [230217 15:14]:
> We should continue the conversation from last year on the topic of page
> fault scalability.  I presume that by the time of the conference Suren's
> current patches for per-VMA locks [1] [2] will be at least in Andrew's
> tree, even if not quite upstream yet.  We will then be in a good place
> to discuss enhancements:
> 
>  - File-backed VMAs
>  - UFFD
>  - Swap
>  - Improve performance for low-thread-count apps
>  - Full RCU handling of (some) page faults

A few other enhancements that we should discuss:

 - Adding protection of detached VMAs to mmap_lock page fault handler
 - Using detached VMAs to stop stack expansion and allow mmap_write_lock
   to downgrade regardless of surrounding VMAs.
 - Fast mmap_write_downgrade by using detached VMAs in other code paths.

> 
> Suren Baghdasaryan, Liam Howlett, Michel Lespinasse, Laurent Dufour,
> Peter Xu would all be good participants.
> 
> [1] https://lore.kernel.org/linux-mm/20230216051750.3125598-1-surenb@google.com/
> [2] https://lwn.net/Articles/906852/
> 
> 
