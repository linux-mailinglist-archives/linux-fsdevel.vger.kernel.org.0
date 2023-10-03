Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79177B7147
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240839AbjJCSra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbjJCSr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:47:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00946B4;
        Tue,  3 Oct 2023 11:47:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I56sr006407;
        Tue, 3 Oct 2023 18:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oWFasx/IEr499R/PgkQP+CSGRJ/Gg4NXisC/iZHyvD0=;
 b=ihz+4Egamj1isQvaIDIUXJftOlkryS1CrHZkFAzWqDGIDCErv3/zYSlMdFXc+TSABYVN
 cAeGj1OTGv6oXtPeEKfe28Hy0rOAS9qQN1CccEpXThlqhxx8MeIYtTjaxjZBV/JfhYtN
 jG4rtIkX0c/NJw6RQczyiv7J6wKKY2lvyxuBwwqzTkTP0dH/+yrElkfB2CaRGAPL5dwl
 inyraTnIHVdpGvRjUWpVCjXr/E0EDwfbhdM6GOd8yZZqJwarXjklLL3Rak90Cs6g4faU
 7tTYTriTGZuRInLDzRMuwswG3+38WDEfhDcqfcZAnKTankTfke0JkvtuQ2kPhcY1lhsG jA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vddta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:46:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393IWv2c000492;
        Tue, 3 Oct 2023 18:46:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46df3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 18:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqBGN7uydZXnfyooJCJ5tmHZ1iPmrMS8h5S6r0Yp0gawxFigxbR+YnihBuYGb4FcIh6qrRn0pPmNRb1YDh1639YnVai0jsgfNiHYrqNFxTmyUp3Yp7IQHCDWsfQQlEWg02ZQBrjcDW+m9YO5eDM/clKt6QTSkoSzt8MWe780rBDTSt7ZkYz+Hphn8RVueJrwjc4qebDKiLTwSg4vQFK565jFJFK79+KvWjF0mjreJa88tZbQNYxVCLQhYkrdV8uLqANzKKmjRLHGNhcs2QlkVq07ADVwQ8jS7UPxsMOmZneFTepPGFAuIZ7wzQKabnl8dCx+2TNRrMByv4XQfsa0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWFasx/IEr499R/PgkQP+CSGRJ/Gg4NXisC/iZHyvD0=;
 b=UvTF8w1UwhGNJELRP2qDe4NiBwC+xASPT7HOVu56ghTgM3xGTznZceJ0UnvLT3a3U3hBHRKN+fUsc+PmdqSu7ioepudXgoVn9y9KWVSV+KgEoLYpVsO3v00rT3Lpitai6MQkLehO9xUclbScQeToU64o3/D1ZgwgNCai1KR2qkVrlkYoWo9vFHhvPAKdfiKp4kAR5ACK1ENh6cVUiKrQdKnuEiEZqg8YyjlP/PZqDEUHFgIthLZiZ+cXFFxS8LLvn/DjQi99XhcvcCQQ8o7VLXWVV9PaazH4QM0/YAY+PkySKu8t7OIVlGtxjabszTF9R/4CTS3Bvi+4GtUq1X5Xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWFasx/IEr499R/PgkQP+CSGRJ/Gg4NXisC/iZHyvD0=;
 b=aNNkDkct9r2HgAqz5OOuAJKQAUOptzbfGD8fSaODUf0CopsWsp8SQVA0B5JPo3B6RV2HJzgHhugJpo9N5ihSWPnoilrygOY3o5sKjyS5VXLkooc0e4YJftvBwxiSpXoVgVi9sdCgM+I0LfUjFn0LZWfU1MsHMvfRxrPZhXAEN7w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7855.namprd10.prod.outlook.com (2603:10b6:806:3a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 18:46:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:46:37 +0000
Date:   Tue, 3 Oct 2023 14:46:34 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com,
        npiggin@gmail.com, peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231003184634.bbb5c5ezkvi6tkdv@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
 <20230925035617.84767-10-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925035617.84767-10-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0493.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef961ad-fb37-43da-6c7e-08dbc4411332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoCkxlpaU7p0yjhQw3sEeDtMA906P8fTz77pMx24vx6nqpRwiby82Lzarz7x43YVvj1v6hefomN/RFTXaERx6sO9mI38+RMIeQ/s0N0duwShBv+17Hidmc+mXrKwcDe64U13/qm5CEvWUSNGy28gvrABXw7me97GrFDta1DagSXteFa7yllGiG2pszQkssW6niD6OsEw+QCR1JerFi+sLlO03KfGXh1z7ogHn2OgDRnMCmV8E0RGC9GgYbTfdV8f3hXv5z3p6L7mlABPY/B/f9D0zsF3NQ9HdqJAKfazan5Q2fGdnPsGvBB5snuoWi7mXT1lwYJCET7rLn0ivzUyMCdZuNbn/TKWvrxs314EUeGvaqoeV9Ce2YJE/kjH/EZ40C4KQxT8dlvszkTFXkyFxwwQy8utE9JFpFMvql2cdGNuaT5Up9iGuedWDOA7dAAgFaut7dWtPsJebEVKiFyvStheK/qyae8ZAp4LCo0AWOlIetg3/Sg30M/EEFpMvkir7TTt5iPgMQs9d8q2nYOhygQM4B5rVc3A2tpW2+INiEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(9686003)(6506007)(6486002)(6512007)(478600001)(966005)(6666004)(83380400001)(26005)(1076003)(2906002)(33716001)(6916009)(8936002)(316002)(66476007)(8676002)(66556008)(66946007)(4326008)(5660300002)(41300700001)(40140700001)(7416002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LlIjUOGx2k5ReFaHD/hnpfc7YYCmvoVO730ih9h69u16UlKifYDi/r4qsAUj?=
 =?us-ascii?Q?M5EMRif4B9bNYJVgp3HxUT8oJ906sKutNRd6mDhsE+jn9nJR+vNr1uajLZKQ?=
 =?us-ascii?Q?xeGKknxJLhrw7M9AiShL9jOhvDUMjAIjyGZBGxkqb+1lvBTrtjWEYa8BrPPl?=
 =?us-ascii?Q?/sBS1FWQN6L7o9AvReMAHRdQV16Msg1W7DIADXjfsGA1nhxoQNqs+UkVz1i3?=
 =?us-ascii?Q?FKGfFl5y6Td6dcW8UziddqRS+O+yPAJpeytZeCF0RJRwNCaHowestahbg+Qf?=
 =?us-ascii?Q?djOo+megpBHJpkpnxIBJsW8VUdJkBgiP3OhSpNHT7dlikQcHxoZ1UX7L975h?=
 =?us-ascii?Q?8djLwZFoMh2nCWRuhTr2y2XJeI8ADgZhIzarQ6A1A5NIwCO69s4p4xbsaqQr?=
 =?us-ascii?Q?+6r/maDODBwi+tK2LzRXYYjRO42/yFoJL7tb4AOPQTSZRdS2w1vMFEnkDMii?=
 =?us-ascii?Q?Q0OYnsohExVVvHK/Kma/8DztIhJ+iqoSYsY2Of9Z04era0N5sFvJZcKZ4uyO?=
 =?us-ascii?Q?DoFeMukgOrYrTqTrefA7y1asktEt/FnbGZzntolPzFKChIWguXX6MaFntmig?=
 =?us-ascii?Q?ITQuGC/g7CqRqmi2s+eiWc4Fpp8FyFUH/epsPNWPWB7jSULUuuHDW5Xy40jT?=
 =?us-ascii?Q?gf2G9aj7PR95LNGPTesg2KPk9BuSalegjjKhmRflPoFG+fg278HVX4hfp6nF?=
 =?us-ascii?Q?WIN5evA4uk4UAeVSnIxYBp9dB1zGc+zWl37pZfi0haB0QVkXG+0jd95yzCs0?=
 =?us-ascii?Q?QUwxmmjirHQ+Au1u0OuEe8yHOxVefHo0637REDatfyE8tzQnR75A5Anw1wSA?=
 =?us-ascii?Q?YSNtS1ne81z4BI+AVXOxGeqZ2fD3EUHY8zEpOHnxW41+ebaRzkRr/FhsvGbF?=
 =?us-ascii?Q?CjSvQIymgLhu/SaYFtE0sbxdD/stv750XbQQGdrWG4vFQKo6g4AayUByuL5U?=
 =?us-ascii?Q?FLKd1zvKshw0JS8G54lLUId8UVz+MPSxXUaTVxXyrxiWs36u+tkv2ZPlogHV?=
 =?us-ascii?Q?xbKcBDQFulmjx8bnr5CgYQMAmDFOcHIs/48rgWYAOO+UpmDEM8y/KokhsIzK?=
 =?us-ascii?Q?cyjq0NMCvvq/rW+csxfNnYG/+/JK7MQv0D8ThJsLer3kWZr7u/QrwwHyvUTI?=
 =?us-ascii?Q?2cI+esYZKEVuw8pbKC+h0J7iUExSa5TCM0eAD7WY4XLAnV/UZ5XX/o3paskT?=
 =?us-ascii?Q?tp/t0TKmAUcHd9mviFHKfAYEpf1kOiKJ2yqeF6qA1y/nCFb8SrnzVxGptcbq?=
 =?us-ascii?Q?hCfrwXa5YrQE85xbVwUq3Ym6R/TlduxZ+G0OwPIWTgrbYPO59dcBVRIl0d8m?=
 =?us-ascii?Q?tq91dcjekvtTjKUWr3juup0InaV0vFzGmUAEDj7Xd5gWRXJhnz9QvUdIJEgr?=
 =?us-ascii?Q?eOjs2bZHXzEaki+JH06vksEBku4l4N5bj6p3Q8pPIZ0rxFSMnAJWX5QUyltw?=
 =?us-ascii?Q?RkcrWpAq5e1A4X1eeRQUSPU3CDWueUcCJGk/yzuGfcSAgKw3YzY8bNU7ljUk?=
 =?us-ascii?Q?QkHrOf//Pmk222lpqcKoygkWnvx+GPCbaVYMH0g6ysEKPC6c+mcbeOV1hwUj?=
 =?us-ascii?Q?r0EC/U9e3I/h7SrWrL/IBCirsMiK1S9qaGSczBc1cblbq7xWFUkKKT4g2Va5?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hlZIjFPTFuhXmlnHD9cVxhJdiVxWifimBYT+RvDOnT1E5EL2Hr7VkMe7mgLm?=
 =?us-ascii?Q?ArbOc8SufJmJQ6iHVsvmy0H1dqHuI50Jg+D8GZ6IClf4bd5MJ7OkfBlOnQTN?=
 =?us-ascii?Q?yn+8gUJFYBaveFjeCHQ52IUKUbiOUNMRe0EQJJ3H0zW+cDG/qik+IGsNIGa6?=
 =?us-ascii?Q?CwL+RT62gTjT4RgTlc9sd3OIbTRdlDQcxNW8CkAxcF1kjzjuxg/x/NwvyaSq?=
 =?us-ascii?Q?xixcUjxTewP9sxL/wkAgMWElVh9GTcYzLAMUV+37ARVnMPKniFZpRnnBkZwC?=
 =?us-ascii?Q?Lc3dWjzLXDWa0LtUVUGsVPe/HXI2Ln9yZufPyG8Gd3QVi30UjENHH1SWRXRl?=
 =?us-ascii?Q?NHuqganDh3Oyznqyn4ncAR3zEGxz0up8MoGRiqQqC+/7EOuO6QMjhH9lYA4N?=
 =?us-ascii?Q?UDTvcRzuJwgp0EB43NBWNVgulKf4aVYCZqk8XvN4MjD1/3yah91vY749jbz4?=
 =?us-ascii?Q?0TuZp7gM7k/9m8ShTztEzyNNmEB8WszqISMEwyL4NpbaEuNYAZrT6Nt1re7P?=
 =?us-ascii?Q?HIytWs+AwNhMkRXopXijZBYJH6TJ5kBN1f5uBNoRrHo0/F/vbYmj3BiskVkA?=
 =?us-ascii?Q?aRotYbWACWeK5wQX6Kfn/+tpC3rZdiJ0wGDjslyeflMFTPRAXYx9Br22j5zp?=
 =?us-ascii?Q?gLfmDGDuxlswHL9PNLp0n9rZ5R3CgsyK+KX1C6blRnr0/xVM5KXuidkNIFh1?=
 =?us-ascii?Q?uaj2K0dOGySpudRcUxbGwrWZkyM1WpymoGoptUmcM7Y/wAGSmMxwS+GAg0d1?=
 =?us-ascii?Q?YbVXQW1goTREWH3t+MROz1zvqhcOZgLfnfAekNGl0P5rU2yX3DfzGmGyy2p+?=
 =?us-ascii?Q?tJnDAn5OMN492FAXcL6L9nM9X/RSolJKYH6VyBqXSBlz8Y6qUXHnvlmuDuql?=
 =?us-ascii?Q?bUkJN7e+hkVQXjK4DJ73IDGZX4fr+wgs7tDEQYhZbiOwv20qYDTQnD1hgNi0?=
 =?us-ascii?Q?tZdpzeir0rxw3jgD0x8zeAK+MCRBN5kl75A3Wf6lEdX8jQ5p0dJKqOlIIXMZ?=
 =?us-ascii?Q?bmRRom2YY/jUbTWyyRfKGt/M4GdYdddctq4FzW/hcJveeNfxDfLt+Fdc/8Hb?=
 =?us-ascii?Q?l/gzPLf45nWdGybU+eBkb8A6kYN1jEGrEQHSxGoWWyhiqOJp/r6sunhWdZWf?=
 =?us-ascii?Q?rkKAK41p4uZn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef961ad-fb37-43da-6c7e-08dbc4411332
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:46:37.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNbjSpYXc7y0GurQPC+RZ544+No155rcChKuP25xjnZNX55+7F93vwSdQuI/LVYbPXZt77V7fG+C6Ei4pgPBxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030140
X-Proofpoint-ORIG-GUID: SqrOnYx1FH0GadHKWWy2DZ3Li97a9hUi
X-Proofpoint-GUID: SqrOnYx1FH0GadHKWWy2DZ3Li97a9hUi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230924 23:58]:
> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
> directly replacing the entries of VMAs in the new maple tree can result
> in better performance. __mt_dup() uses DFS pre-order to duplicate the
> maple tree, so it is very efficient. The average time complexity of
> duplicating VMAs is reduced from O(n * log(n)) to O(n). The optimization
> effect is proportional to the number of VMAs.

I am not confident in the big O calculations here.  Although the addition
of the tree is reduced, adding a VMA still needs to create the nodes
above it - which are a function of n.  How did you get O(n * log(n)) for
the existing fork?

I would think your new algorithm is n * log(n/16), while the
previous was n * log(n/16) * f(n).  Where f(n) would be something
to do with the decision to split/rebalance in bulk insert mode.

It's certainly a better algorithm to duplicate trees, but I don't think
it is O(n).  Can you please explain?

> 
> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
> fails, there will be a portion of VMAs that have not been duplicated in
> the maple tree. This makes it impossible to unmap all VMAs in exit_mmap().
> To solve this problem, undo_dup_mmap() is introduced to handle the failure
> of dup_mmap(). I have carefully tested the failure path and so far it
> seems there are no issues.
> 
> There is a "spawn" in byte-unixbench[1], which can be used to test the
> performance of fork(). I modified it slightly to make it work with
> different number of VMAs.
> 
> Below are the test results. By default, there are 21 VMAs. The first row
> shows the number of additional VMAs added on top of the default. The last
> two rows show the number of fork() calls per ten seconds. The test results
> were obtained with CPU binding to avoid scheduler load balancing that
> could cause unstable results. There are still some fluctuations in the
> test results, but at least they are better than the original performance.
> 
> Increment of VMAs: 0      100     200     400     800     1600    3200    6400
> next-20230921:     112326 75469   54529   34619   20750   11355   6115    3183
> Apply this:        116505 85971   67121   46080   29722   16665   9050    4805
>                    +3.72% +13.92% +23.09% +33.11% +43.24% +46.76% +48.00% +50.96%
> 
> [1] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/mm.h |  1 +
>  kernel/fork.c      | 34 ++++++++++++++++++++----------
>  mm/internal.h      |  3 ++-
>  mm/memory.c        |  7 ++++---
>  mm/mmap.c          | 52 ++++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 80 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f1d0d6b8f20..10c59dc7ffaa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3242,6 +3242,7 @@ extern void unlink_file_vma(struct vm_area_struct *);
>  extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
>  	unsigned long addr, unsigned long len, pgoff_t pgoff,
>  	bool *need_rmap_locks);
> +extern void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end);
>  extern void exit_mmap(struct mm_struct *);
>  
>  static inline int check_data_rlimit(unsigned long rlim,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7ae36c2e7290..2f3d83e89fe6 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	int retval;
>  	unsigned long charge = 0;
>  	LIST_HEAD(uf);
> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	uprobe_start_dup_mmap();
> @@ -678,16 +677,25 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  	khugepaged_fork(mm, oldmm);
>  
> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> -	if (retval)
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> +	if (unlikely(retval))
>  		goto out;
>  
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(old_vmi, mpnt) {
> +	for_each_vma(vmi, mpnt) {
>  		struct file *file;
>  
>  		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
> +			mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);
> +
> +			/* If failed, undo all completed duplications. */
> +			if (unlikely(mas_is_err(&vmi.mas))) {
> +				retval = xa_err(vmi.mas.node);
> +				goto loop_out;
> +			}
> +
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>  			continue;
>  		}
> @@ -749,9 +757,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (is_vm_hugetlb_page(tmp))
>  			hugetlb_dup_vma_private(tmp);
>  
> -		/* Link the vma into the MT */
> -		if (vma_iter_bulk_store(&vmi, tmp))
> -			goto fail_nomem_vmi_store;
> +		/*
> +		 * Link the vma into the MT. After using __mt_dup(), memory
> +		 * allocation is not necessary here, so it cannot fail.
> +		 */
> +		mas_store(&vmi.mas, tmp);
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -760,15 +770,19 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
>  
> -		if (retval)
> +		if (retval) {
> +			mpnt = vma_next(&vmi);
>  			goto loop_out;
> +		}
>  	}
>  	/* a new mm has just been created */
>  	retval = arch_dup_mmap(oldmm, mm);
>  loop_out:
>  	vma_iter_free(&vmi);
> -	if (!retval)
> +	if (likely(!retval))
>  		mt_set_in_rcu(vmi.mas.tree);
> +	else
> +		undo_dup_mmap(mm, mpnt);
>  out:
>  	mmap_write_unlock(mm);
>  	flush_tlb_mm(oldmm);
> @@ -778,8 +792,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	uprobe_end_dup_mmap();
>  	return retval;
>  
> -fail_nomem_vmi_store:
> -	unlink_anon_vmas(tmp);
>  fail_nomem_anon_vma_fork:
>  	mpol_put(vma_policy(tmp));
>  fail_nomem_policy:
> diff --git a/mm/internal.h b/mm/internal.h
> index 7a961d12b088..288ec81770cb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -111,7 +111,8 @@ void folio_activate(struct folio *folio);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *start_vma, unsigned long floor,
> -		   unsigned long ceiling, bool mm_wr_locked);
> +		   unsigned long ceiling, unsigned long tree_end,
> +		   bool mm_wr_locked);
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>  
>  struct zap_details;
> diff --git a/mm/memory.c b/mm/memory.c
> index 983a40f8ee62..1fd66a0d5838 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -362,7 +362,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>  
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *vma, unsigned long floor,
> -		   unsigned long ceiling, bool mm_wr_locked)
> +		   unsigned long ceiling, unsigned long tree_end,
> +		   bool mm_wr_locked)
>  {
>  	do {
>  		unsigned long addr = vma->vm_start;
> @@ -372,7 +373,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
>  		 * be 0.  This will underflow and is okay.
>  		 */
> -		next = mas_find(mas, ceiling - 1);
> +		next = mas_find(mas, tree_end - 1);
>  
>  		/*
>  		 * Hide vma from rmap and truncate_pagecache before freeing
> @@ -393,7 +394,7 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
> -				next = mas_find(mas, ceiling - 1);
> +				next = mas_find(mas, tree_end - 1);
>  				if (mm_wr_locked)
>  					vma_start_write(vma);
>  				unlink_anon_vmas(vma);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ad950f773e4..daed3b423124 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2312,7 +2312,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  	mas_set(mas, mt_start);
>  	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
>  				 next ? next->vm_start : USER_PGTABLES_CEILING,
> -				 mm_wr_locked);
> +				 tree_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
>  }
>  
> @@ -3178,6 +3178,54 @@ int vm_brk(unsigned long addr, unsigned long len)
>  }
>  EXPORT_SYMBOL(vm_brk);
>  
> +void undo_dup_mmap(struct mm_struct *mm, struct vm_area_struct *vma_end)
> +{
> +	unsigned long tree_end;
> +	VMA_ITERATOR(vmi, mm, 0);
> +	struct vm_area_struct *vma;
> +	unsigned long nr_accounted = 0;
> +	int count = 0;
> +
> +	/*
> +	 * vma_end points to the first VMA that has not been duplicated. We need
> +	 * to unmap all VMAs before it.
> +	 * If vma_end is NULL, it means that all VMAs in the maple tree have
> +	 * been duplicated, so setting tree_end to 0 will overflow to ULONG_MAX
> +	 * when using it.
> +	 */
> +	if (vma_end) {
> +		tree_end = vma_end->vm_start;
> +		if (tree_end == 0)
> +			goto destroy;
> +	} else
> +		tree_end = 0;
> +
> +	vma = mas_find(&vmi.mas, tree_end - 1);
> +
> +	if (vma) {
> +		arch_unmap(mm, vma->vm_start, tree_end);
> +		unmap_region(mm, &vmi.mas, vma, NULL, NULL, 0, tree_end,
> +			     tree_end, true);

next is vma_end, as per your comment above.  Using next = vma_end allows
you to avoid adding another argument to free_pgtables().

> +
> +		mas_set(&vmi.mas, vma->vm_end);
> +		do {
> +			if (vma->vm_flags & VM_ACCOUNT)
> +				nr_accounted += vma_pages(vma);
> +			remove_vma(vma, true);
> +			count++;
> +			cond_resched();
> +			vma = mas_find(&vmi.mas, tree_end - 1);
> +		} while (vma != NULL);
> +
> +		BUG_ON(count != mm->map_count);
> +
> +		vm_unacct_memory(nr_accounted);
> +	}
> +
> +destroy:
> +	__mt_destroy(&mm->mm_mt);
> +}
> +
>  /* Release all mmaps. */
>  void exit_mmap(struct mm_struct *mm)
>  {
> @@ -3217,7 +3265,7 @@ void exit_mmap(struct mm_struct *mm)
>  	mt_clear_in_rcu(&mm->mm_mt);
>  	mas_set(&mas, vma->vm_end);
>  	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> -		      USER_PGTABLES_CEILING, true);
> +		      USER_PGTABLES_CEILING, USER_PGTABLES_CEILING, true);
>  	tlb_finish_mmu(&tlb);
>  
>  	/*
> -- 
> 2.20.1
> 
