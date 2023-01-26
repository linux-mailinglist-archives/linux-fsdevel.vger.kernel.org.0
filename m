Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEBB67CBCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjAZNO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 08:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjAZNOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:14:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC60D65375;
        Thu, 26 Jan 2023 05:14:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q8PDin015690;
        Thu, 26 Jan 2023 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=na1Hj4G8iKkTOpXYv04kjezfHoNa0BIDOd9bTzUdQpI=;
 b=MKaHdHkzDUrJQTTZGb4NaAs3aYg1y7gfzWuTaE5hN9SEaqwvY1D5d9TMopNN8P/p8LFo
 tHGzZKTw+4YuEw8MXMafgrOQCfFhAVDxxaRkmOPDQLWcwuWmR5WhbRfsj9vKcvssiBxq
 R6CPEmwsT44XcXp45x1PQEVFT3CWnz5I2riFtnoMuP9/JkRWJgB2BuL+5b8fl0zVpwQG
 CCtxHsyLIgWkl6KHaj7YXB5DLl5kNlsiIgXt+nybmuu5W4UKk2OGM/O0jwIF64jcbKpO
 0GUVCORCiKSEWqjcB2i+J9e2ov2oPLQ1vca7vV2kzH8Ea5tQHyg9OmRPjUeK789m2KIF 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u3299y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QCZbYE028394;
        Thu, 26 Jan 2023 13:14:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7bvx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 13:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm1JAY0HNPgvky1t1lN4wqAGV7/9JOiOOlqcsVjWw1uFLiZU7m6mgv1Cw33ZLtNIfILKGDp/lg8Nyj2EOF+a6TsR2iqmcencjUoAf+oGJ36dmcsjjPLSeV0AiehgQGbT+0FBLc/UP1GRd1joLhL2wK4o8eMDWCIO6wmzyRtkvc71fJhJAE9vdaovZGF/tG0TJM0KQpNI/NxuwQS/IlunMDR/u3oC+fk1gAJVdezBGQPlNEAgtSERrnjhN09bq+VgEdZC2ldS2vH7x0VjFKGVppeOaNzDXJek1IAnpW0pqECSzinI4t2/EzBnlC10zVY9Mv7NmpL+o+Su+SvOT6hBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=na1Hj4G8iKkTOpXYv04kjezfHoNa0BIDOd9bTzUdQpI=;
 b=EWrGzhtLGiBt7W97AGyUZjIHSjFirlgSTK4J3o9OH3UYWyAxP5fWMojhG5yIPB9bDfx3v1i9hylwP+9JJR0m03pQIUvenR5wvvj25KOWHD81XG0yfltsJQYI2tGZunxbFckSEH+MxI/F3Da2n7Zs17oWeX6AbSIsdq79Pytr0vhOe7DztjG7d8fhjS873nBtuiLnTET85C5gjmjzX1KD/c8ZCSAS60gUqJBronubb78IZAOAoL1NRquv07HotkRP40KdDC/c9q2sYgbTtipfdyNOmXsXo0NACDG4otkIPHCTuINrCp0wN6VJB3D0hsTJK5DVqL0Pnmy89d7xecyrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=na1Hj4G8iKkTOpXYv04kjezfHoNa0BIDOd9bTzUdQpI=;
 b=IV7f88noPj/OEtEKDSnYNoptGg0m395OztchUrfv8lLtFS01VXHNujEWyjtkwIurrO2TjFRMZ7RSsalUhhwm+6f2Qr/wL2YmAvCGiy9NezSkRCF3w57JU07aROwGQeW10pkFKn8ULDZ1TVw02nzxc0/VSqq/2dam+kBdfucQjyA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7249.namprd10.prod.outlook.com (2603:10b6:8:da::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 13:14:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::7306:828b:8091:9674%5]) with mapi id 15.20.6043.017; Thu, 26 Jan 2023
 13:14:27 +0000
Date:   Thu, 26 Jan 2023 08:14:24 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, dan.carpenter@oracle.com, dvyukov@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, wanjiabing@vivo.com, willy@infradead.org
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
Message-ID: <20230126131424.ufk6zspn6fyzw5l6@revolver>
References: <0000000000009ecbf205dda227bd@google.com>
 <0000000000004dc42605f31dd05c@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004dc42605f31dd05c@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 408b0762-59ce-4dd6-8c8f-08daff9f405c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PwncChRKFfJ7XtmTIxyoay1cI/ypx6G48yg34m555ZAWlbay6+FBzTA8LyXGNNRid9w/7t4jCaRxih2J4ctnOreVVWKkwlCN8djnhB9vWGk1x11jde3d0dY022pOM2283ygaIc6S2EqruarH4mraHrYTOhyHeEzNjb8rI41jYEe5ebUMipMsy1mV/H35F0KKCVwV8HtLwwy5P+LF3ZH9KeuoB1kb3oLZMZthINfE9Cg/AN+7fz+KsczifW89vQNQgngdaSRTlSUBKJHgxIhr8fMV0u+FQsGVRVH3D+DGlbTqKVWywe+zjclU+KMqtu0LeZtBYQS9b5bktR1mMzyo6EAru31PpdIzq2yWcqH+jS0pBNlyvjnBropv8+vCe2We7kyz7ipBYufsaXk4BRmmJGLtMB+Cbp5JUaWBEPC1eWHz3abhP7Mv2vrYySKPhrru2IAwNJEXshVYeBA53CBsEx9iDvY6X9KRusVVSjtXqfflCPXHoxTvVVR/uU38Kn7jDmGe56E6d6x/Cvpejukc+Q1jqEF2DP8RpmdqEiaRl9YEgXH/twGveBOg7plw18DgyBtHJeNbdceHLUOD89YEHs8/RBNLHmIvH8jYED6lvYJ0U9VxTiznvCDFzkiLzVvEdd0MD8/+dLCKKu4vjEXuL+geffc+7iTFvSt/e5/b7XkS462d0uMrydld+z6p+9vOarhxUVuiohwiV++NaPlEoNsaix792JR9ofwF3XJyuMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(2906002)(7416002)(5660300002)(8936002)(33716001)(41300700001)(478600001)(26005)(6666004)(6486002)(966005)(6512007)(9686003)(186003)(1076003)(6506007)(86362001)(316002)(66556008)(66946007)(66476007)(8676002)(4326008)(38100700002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2imZSwc8DrLDlvj7+vhICpsb3x/dXqIDf/z+JloV/OFS0ceweavVKSRhYKBt?=
 =?us-ascii?Q?qtsY3EeEQny10W4Ce9/CeVtldmK3tAXOdrTiem6snemRovrdNMpO881Lzcg5?=
 =?us-ascii?Q?9Rz0QdsfdCYZsft/UBIMbDl23dNb9jhteG3OemQBNKpFf4/IPd0Bn4QEGvpz?=
 =?us-ascii?Q?fx3/DctifCCKMl2SdLKvLgYGqR0o2DoP0BeRol+aX3CNtHKcWMwAWODOaNMj?=
 =?us-ascii?Q?/1IuphYugBgyml8/kKcxCNYBhCatJD6+dfUK9cVG9r2Wskhd6AByIpCkICHQ?=
 =?us-ascii?Q?8KB8thRYyGIK48qfGMpnV3OmUubdOGHFpKVLyQr+gD6jEtwzs6E7Sp8ZDENw?=
 =?us-ascii?Q?yB5jOiYMCAVPVmKPUlbc+HjeCmYRaX/RdLOqyCS8+XdQnQdGvoyA8IefMmdk?=
 =?us-ascii?Q?CYjW69lbDGnmlAYYIo/OOyHdjW+KsT61Cnir96jlu1qmaVMV27xnprC/44a8?=
 =?us-ascii?Q?zZYkRM2VGpCzM9b58SLWpXVpdW6D9/pmqn2lVefhfBq8bluKTSXj4Xy5Sgfo?=
 =?us-ascii?Q?aDUUTxdejjfXiuPS8pDR1g6PiBAVf8rj8kE3T6R8Omk4kNfofOtXlYLblopX?=
 =?us-ascii?Q?/q+xnmpZSPmv2Mjib/9biNQRR7qvKOG0ZWcMKQewavLUqk2f/P6S2NbJVkC6?=
 =?us-ascii?Q?X/L79iJFYyNfyZ0Iwnwk6g5ivINTwNaa50ioYFz7S8C5de85EsWlQlzL746W?=
 =?us-ascii?Q?9TvdtDoAQDEp65024KMsjZBiyCjD9F0xM4G/cbKhGImmZ48FCaTl2esVU1aU?=
 =?us-ascii?Q?QqLRMyETY7/hVHTbCHK4uGpg7WwEFR92Uhqpxl05LOF9YLuBkOtHM8La0XBl?=
 =?us-ascii?Q?6a8Ul+FGkeDjHWmexmkfE3bPpP+tS2ib9ehe8BTX4BrAZI1w9ze/+2LdI5EN?=
 =?us-ascii?Q?MuJV83RF8w+UB1Zom5OCiL+gAYrCyyHdttkxJXc+KpvTGOpGykr89mukk5D6?=
 =?us-ascii?Q?IjoAH3WGQctjm8IqNBYjA3xCx8o+EJV7kVZJJ8SWwIYZoCGooBpCQGCMv4YD?=
 =?us-ascii?Q?VEeZ70YvxmwoiyrnazE1FVVjwc7KqQc5IFYOlkksvoMIAdRIdUSHncQsXdiL?=
 =?us-ascii?Q?82mDMv11MSQaa0emDW8PpozkfkV6iet7Fm3WxtcAriRdT2BQrLZk9SDdbpQj?=
 =?us-ascii?Q?zaamWw8XhnmkTHk8qNk9MA7lcdQQGWDxCvUybJiCTh+TYaFNr5IC/Qep9EnI?=
 =?us-ascii?Q?HYgRRZ/LUSRMSjKtA+jJHC96cCWc6wyhfVi7PSfly9xjPO1uiFYI0V5aQzvG?=
 =?us-ascii?Q?GDrupmnTNIOMOIrD5nPbrmYcrJUtSCaDricc/FaYfX4tEesp38bBaTfYofma?=
 =?us-ascii?Q?UYwhcArEk6zG3yF16kyRF1oEzoocpwTiE8fIoLtLKkRvRji1xIXojtxIzN60?=
 =?us-ascii?Q?9g3xQWdV9/5yQUZPT79fj4hb9Vvd766859Ovowj9DxAMlfdUbC9OT2EbNt8L?=
 =?us-ascii?Q?6c7rJkb39Jpjn+SGOz8O+s0hpj2JCsIBL5P/pkBGueEjcCQsEEptOztliyYA?=
 =?us-ascii?Q?Ls4DOlYIiPC5rGZVmDspcnML0VDdyYKAC8DEg1oO9mMtnsWOwaXsMvUwylpi?=
 =?us-ascii?Q?nWBdl3iXjHFQZvFDHKySKrYN2orC6t9r42XeDZQ7cMbpZP6rrLmdDYulhNcE?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JTQe/YCihmhldaTZQlUOi7TE65f4h4LD+mnpW6ropFMptlBMfaU08+UzDo+Y?=
 =?us-ascii?Q?Yw3jqLjvxHVJl26xeolv6CZ34o1kTADUIx67nwT6E+NTMNMgxxDC00IiBfZM?=
 =?us-ascii?Q?R+0KWOCfpHYxMedoVIWkJIEZtlYUf8QMQe3VyMIzNE4M+yzmwkfqf1FT/3+p?=
 =?us-ascii?Q?awTcmoKrYap1SI4PM7sq3M7YmS1g7OhiVcwIRIcMLWORWE6UGB5HX1CeIBFI?=
 =?us-ascii?Q?aN/eltgvcWDnEY7JyN1Atq90/867eWlaZrYuKuFwVRNHAU+X1c0pDzyLIjHO?=
 =?us-ascii?Q?xEPj76fkCkuJUlls4BvlmEyDRRCffcIipHON53eqalnkW6438bOkmA7YBkvq?=
 =?us-ascii?Q?QnCRZTGVovPzURX8I9orBYx0DdnA4A4Z+LriD6M98GrMk50epjAcfj3bePXy?=
 =?us-ascii?Q?MLNBxS4fg646BmAwVYyLaRYBf5MpmMD2zf5AOgsN4vCuih+xf46Y9gW1KQQ3?=
 =?us-ascii?Q?JkGV7rN+PeOp5j8sygOhBcTnkgZ0qMZJZA7evtHW43fEqOW3ux2wY9FEt4hi?=
 =?us-ascii?Q?CiQX94znirGl6k9xJM4VSMcUdgYDRToPEkwXf5LdGboBJLQbgX1DFS8eLZhP?=
 =?us-ascii?Q?w/lhHzaPYpkbseTu6Wrx9kgEmOTGun6yuzIh+Z/AN9gWzHw3mUPqR55gAkRa?=
 =?us-ascii?Q?pbfXtN2PP4Ytfxe8Gp3ZriCAtlVoS651Zj0CMFN3kG5yKmIUxzBY+IFCxFYj?=
 =?us-ascii?Q?42VOmHCwNkPSRAeTGNjTcRz3vS7fvciz2kyC27b7tLApND9Y1/Ly6km2mNxO?=
 =?us-ascii?Q?+RpPmIcL0NcgOd7uGDfxXc+JD66ioFONYdY74ULLU8KYQEB+M24HLr7Vkul6?=
 =?us-ascii?Q?AxGFtH/RwatTwVEH4iKOxQ9ttYMTnBaMt3Mu9Vbxcva+Lk9QDxNpIBe/X+8b?=
 =?us-ascii?Q?W2liYSRxo3iqMjvpnqMPWbYFR8BG5jFjk4fR495gjVHki87XLVJULhEA/TxT?=
 =?us-ascii?Q?1vx/PrwXCPz0iJNwpkQGwhE4MKzlI1CdPVx1SHemU5yHXEupTlNnKnotM7aF?=
 =?us-ascii?Q?Cr3VMFuzWuPtSDJR8ZKlLWwL+4XRAruxJGYA3+7e1IawyGGCB72kuYdOL3z0?=
 =?us-ascii?Q?bWyxLzJehUQMpNgQVCbM1I2drR3tnH1taOhtrJ3u4bGdkX3Xv8A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408b0762-59ce-4dd6-8c8f-08daff9f405c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 13:14:27.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nkcr/4scvh/rZmAnkbqaahs+8PXQUrX5WDVNMY3w+jGweuLfD3Zh41NgBsCJNeYsqZqAFqNy+slIo06KvqoG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_05,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=790
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260128
X-Proofpoint-GUID: s9wbDEGO1dFoewpa4ayczzk2WZfp4e5F
X-Proofpoint-ORIG-GUID: s9wbDEGO1dFoewpa4ayczzk2WZfp4e5F
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister() 

* syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com> [230125 17:04]:
> syzbot suspects this issue was fixed by commit:
> 
> commit 59f2f4b8a757412fce372f6d0767bdb55da127a8
> Author: Liam Howlett <liam.howlett@oracle.com>
> Date:   Mon Nov 7 20:11:42 2022 +0000
> 
>     fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129e8afe480000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> dashboard link: https://syzkaller.appspot.com/bug?extid=7170d66493145b71afd4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bfb2a9880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b1d319880000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister()
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
