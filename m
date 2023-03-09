Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F86B2F84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 22:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCIV27 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 16:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCIV26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:28:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88776637FB;
        Thu,  9 Mar 2023 13:28:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329Kwo8Z015953;
        Thu, 9 Mar 2023 21:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=NqQxzGPjidhwY3xuGHLkpgFFE2OJr1EmRyAuefl65CI=;
 b=OMdU3oFhEFzrqATpaGVfla/qzpEQxbHwgJzlv+iVFWXQU6Pj9X8H30NcOHuCvFw9CA0k
 14+6iJqHczjep7YlBTUjXP/eLc+50LFdfPqMFdyljLtz1tbP28w1DLUn7wMFReAJR3Hg
 bj2FMCn2MA0kYJIoLUO/zgWaD7WNVfeA4YRMptaUNnBEvMkA8nxKYPFTT/VwVDwri/7l
 WMRReM21kBZjD/5ZbBxy1NTHJBukHO1L2OI0oTmpJYTsgSokwZB652XOhPZ1FD0jRxN7
 3Ml3Eq7GW77rjvFecb6MrBrOR2h/1Xfo6VdN0rYDJKIXnQADgbrj3C/FtZ+kKmX6LJ5T tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ckus9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:28:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329JuwNn020778;
        Thu, 9 Mar 2023 21:28:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fua2jfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 21:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmcrzbypdZ1lMoPbzNgVFT5DmKZBuP/qcGNScSNVbF9DqTQlP65ErPLU6JwtFbYZ1PFghaG9BPpicyFoOyITC0fRsE780VWR0Q4rit9Q37mz8tD71RFUBFa25YhfHPH04/P2O6UUwu9P2Nt37kbMvNzU8wCUHLr7O1SYPM1q89DW4gcJ1NJ2VmVB6d9acrI37nlIo1wEN6yPw9wr1JkVh9GoSKp14DZs1twNfK10Nbu4yDASpNTtz6oMQyY7soV9HA8Iq+yoRcnn7QXbFVEEJRu8LRFxTH0dLWzhjgfc5LOI8hdT1hyX5+Cjd3+EouUj4VTXubBwLxZY00MrjtVZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqQxzGPjidhwY3xuGHLkpgFFE2OJr1EmRyAuefl65CI=;
 b=haCV9U9N4RmrdWV8htGrfqJ0lkIXwTOk1pjR83TCwmJgC+BZQvSHEpT0MrzTCyZsnR1D7/TCthPmhTZ6QDt29/F7s14X7o0FSajZnbgiuSqko7B9OpkAgYO5QsYMYz+exKUl/GG0D9M5qdORPf+OZ++Dy1Kp+CQztzfCHvYawIIp5Yqw/lOf0IsTrdXj4moLQErq0GWAKVDNDHWYpZ5Xg6zwp3/5OCbKZz7N7oMgspOKf/CGvM7u2GGDjQ5LMTMBtDVK6oFeCTYvnET9axiZCw2DsewvzgvByHEX0SceSEYKAj6DMAK8HIR/DJnk/01BfompdqyPPvwTYiBVPuNWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqQxzGPjidhwY3xuGHLkpgFFE2OJr1EmRyAuefl65CI=;
 b=TIhRwt6FS99pFAM9o8Rkcn3m20J0rHhM0G4yPi7DXKDAHzr9eNBM+NsWTSh8yJ5of7X/56RbXfMhQPMIDY/0NysTUesCT5Yc8TqcPZWMYy1V9TDEWdwrVoCuIPqPx1EtZ5SLy8nWoEvvKj+kOxHGgKOvD/UmbfRiiiKtWDNykAM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5159.namprd10.prod.outlook.com (2603:10b6:408:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 21:28:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 21:28:21 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dan Helmick <dan.helmick@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttytbox9.fsf@ca-mkp.ca.oracle.com>
References: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
        <ZAWi5KwrsYL+0Uru@casper.infradead.org>
        <20230306161214.GB959362@mit.edu>
        <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
        <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
        <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
        <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
        <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
        <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
        <f929f8d8e61da345be525ab06d4bb34ed2ce878b.camel@HansenPartnership.com>
        <ZApMC8NLDfI6/ImD@bombadil.infradead.org>
Date:   Thu, 09 Mar 2023 16:28:15 -0500
In-Reply-To: <ZApMC8NLDfI6/ImD@bombadil.infradead.org> (Luis Chamberlain's
        message of "Thu, 9 Mar 2023 13:13:47 -0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 087202da-411c-4fa3-c669-08db20e53529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8YzpA26JSvWoqi7q2mdqnGljeQjtcdSZt7JWIs0O/oGbMH6U3xGzzOX2Iyo5uuKQxirdDNTNYEHbuJnb1BgBUMsn5OHplH8HhxgU9YbZ+u/YP2pq3MwmWXux5mJKlic4AZyyudc1ZI6yXUNlWdolMy4UFKvfehMjGIVAg6QQE7JvSgCHf9Jbz572ZXoO6aZhUy1/pG08yMoU2zNSNWX55Zzio5aeqseq0iN2sW1s7AG8YTK1eYH2EMPUKopUz8RfmvWFRGv5j1qSDbcxGektwvyon3B+OfLpWf/Wa1tCglntzj40vW8QFH8IKEjgBkeMjgDltgwS2UScRxYpxtoORFV3Nz4wqoykwMJnbWDhYcn6qoqNjXnqLweCkyzohodatkYrigz9rZ7TaLdOwrZ+VEK6FV5od5M8CQgXV2vLihhF59mF+aLgFuJJcPu7EeNE3U8XiA2P2PcLQ1POBDawt1xeh+En5p9C7cdtKwQxsVGiZrHQOWn5VOeCBLCOot+/qX7jVUHEzMusDBgPa66WFqEfSRt+4nFrknO1h4FfHZyKTAIRqeC+Ihxhp+l3DiCw8VO/7/cURi6G4SMK0TnlzP4ZjdxqIQuZJjsZkKbSqaNObigHWPkAucaj3Zv+02o25nUjRCw3Y4EPSwVY93PCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(66946007)(2906002)(7416002)(5660300002)(26005)(8676002)(4744005)(8936002)(4326008)(66556008)(66476007)(6916009)(316002)(54906003)(86362001)(36916002)(478600001)(6486002)(38100700002)(6666004)(6506007)(41300700001)(6512007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hczFBxNQJamlAlgRgO8yKvMA4CIQh4SpOuySHnWubaHJNvGOTp5/vmRQyJNC?=
 =?us-ascii?Q?+36VSOzUe5mCqa7ziM51akgDRsYpAC7Ks1EUTaOXgIY5jScwWiunmhaGsoXZ?=
 =?us-ascii?Q?0m6AZlhueQlv5SGt+1jJpwGPGvKiZl0j92/F/Kbp2bfHTaz0/7hbwYhZlFOu?=
 =?us-ascii?Q?pMlOduBZ4hOcNv4AO45NcRG4W7PbIx0zAQh8BbR+MtDhrOO5dpnW/bj2Du3U?=
 =?us-ascii?Q?HTXrS8OTBSiIi7cz7X3Am11RrTAvhiKHu7Xr0kgStuFdi1eQX+Ut6AhQqw9A?=
 =?us-ascii?Q?wlHNo6nYmcJzuo+EllEaSZM5P3OoLo9vcEj4DhptyXLlwl2Gt6f4NhvIUv1P?=
 =?us-ascii?Q?cxsYcyIECMJnOp0Xokv+RxSZTRITIrRAFbTbLPTIjv20k6Qg1u99ZwnbUzDs?=
 =?us-ascii?Q?hOF/l1klYNv5vrOLCdT4F8i53bjxiK4MzL2useMI42X/4XdARXnH3r6oTrrM?=
 =?us-ascii?Q?5NfDqNpSn27NN8s8RW2/asZBgE6rN1tUbZhF+tXF5VFzz1hXyI25CP7flPOr?=
 =?us-ascii?Q?29LtsCNNZN8IinzWNxnETX08zPhACMkkmpD7pTFteC3oZcoZRrwA+7390LYL?=
 =?us-ascii?Q?0F1C45OQ2mWc3rRUydspFiofEfdkWuBE+XzVLVgRmNEQ3/ZL4/tLt/XbXpkX?=
 =?us-ascii?Q?XH6TuRao7gxEM196uPfTXq1mH5qDHX+KwgdSddqo7sOKphVKoneVNvwi/w3f?=
 =?us-ascii?Q?TgQ9cU/xZBxUZXezn0QHTVzfqJFshKT8iFTzdOcDdt99JMS2iVxN6DyvgZ6p?=
 =?us-ascii?Q?XOOVMWYrAdVkWpLHoLR3uU0QKxDy8Aq7fYWdMmggMlbR/lb1CBb17Liy4iEX?=
 =?us-ascii?Q?8e4/QxmZJ/OCIuRELshD6iYXJwvKY3T02zTRqLVYZCEX2nXMEnPwh9uV+08c?=
 =?us-ascii?Q?pUCqmIY2QKP/fyJvGbCxuBWPKW9dYGpR4+boXXgDxy1u0jo8LZ+ddeXww+PO?=
 =?us-ascii?Q?QL5Ue9b0QnaHebBfWEMZBrcF1ZVLeuFTnE7iiR2uSo8I+vmX79kZtK+q7hGN?=
 =?us-ascii?Q?qNYI9kGDjyZc6AvRwT4w7nVJu7oFoRyi0RIMX8DqMYw7zztXwW0UKJxXjJyk?=
 =?us-ascii?Q?AyWgvBFqFt8kzAHiegh8ahCFX70bhzsC8qrVwecBLPOwwOy984wUUOJYEoCZ?=
 =?us-ascii?Q?d6LZ3iMgeVDcJWFzS2lxP0ma7ZVbUJmTFgPWFK1xtNruysgebg8EJBKI6BEF?=
 =?us-ascii?Q?X7Ss7zSEd5QTR2Gv5dh9A6p3TPGxQ9j+awlO1mb+DDlCqDaqKTtwkfuRBSXi?=
 =?us-ascii?Q?9gTMww6uY5p+wNk9sHu9sDniTpXjafEFrX/nxDm7NeX8341qdyI/RDniLPZ9?=
 =?us-ascii?Q?/uFcvzAHHBmT1ZpdE/Pp2/6ukf6YYQTUnztz3Yfej13lVf6m77n+mOuo38/h?=
 =?us-ascii?Q?CZJl3Cxyn51pVi62/JEBHa6/MFRe390EXlp3jce2J0GzThsgHIxnG5D4VK5t?=
 =?us-ascii?Q?xracUkqOC2NLjrQDMxH9nMmdTT55uQ+n12qHMtO6OSvSNdQ8y8/SUSbF0+9e?=
 =?us-ascii?Q?RCvSD1sUcn2c/BwKQcMzaIG9HH4CMtOjH5pdgQ1su8QD3Qq81J5vbtDfZFOF?=
 =?us-ascii?Q?1mSk37bnznfe17lWyWJT0SNgcTqKLDNZyWAF4KPstaUKd3gvzb/ar4rbr1u1?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n+/x3XgMGhdsWTr/u3WT7MOA7JWYHMFzgwTyNQkedhOXwM6t7cObIuLSBztW?=
 =?us-ascii?Q?p4IoiCuyI2RVypjiD/5rLY+9Zz+ZFdwSMasH8SJjTrmKwwEWRnn+za997mcf?=
 =?us-ascii?Q?H3u2qMimnlNDdzlrpHC1pcYVtL5H2L/fJhfY7mcreSFjf3507wKqAQ/zDSfM?=
 =?us-ascii?Q?qCN35l2wCkJ22Q1NDuR4I9ocl27OXOsiHbEFxeoBpQAJy0tpJzDNnJIX24LW?=
 =?us-ascii?Q?cTu0EKREsUBml1uQrmGh2y/yt8QWcFynC1+Fa9me2p0rhKpV8xBs7efzm8i5?=
 =?us-ascii?Q?e1IzmVP/H1WAJMDM//h5Bdorred6rtPbGNXRJ7vfVJ0QOEWlL6OZfhekJW0l?=
 =?us-ascii?Q?ng9AKiBTUcejJHRt4SVAyoWyrEPd4jHCskKGWoKvhda8PHsaGJ+/bbz16UM1?=
 =?us-ascii?Q?7E1sSDCsUdYw+d0t5mM0mq3NK8FmnUY8Beqo64PWhNCwdH6THCLBP2ZoA9w3?=
 =?us-ascii?Q?dUXRnUekBCOvvSJD6CBrCPbMFQjC7yPPCbH9cH1RFrBDYCDCOVmI8Br6RuNB?=
 =?us-ascii?Q?yc0fn34tUjweHVHyrEJfl2gdb9pTQo4FxiDOquhUNPJK3+BD/v4Ym7ZCSsRS?=
 =?us-ascii?Q?Us08QbHn4vK21VEXQs1SvVtqp3P0gE0rijN1OlGdpwGLhsdDXbYN5WwszJAi?=
 =?us-ascii?Q?7vYV8+nwlrBrW9GKXtcqO1/LNMw8vS/Mx1cO+SSkoCmA1ORBoNUOSpWEuKhx?=
 =?us-ascii?Q?QcZVWDRycAhqBl3dFGe1M/wU/+fJN/V61cEDJoCen3VzNaXuEqqb5H1V0+5e?=
 =?us-ascii?Q?gsqZfcxrqFGrDFUppMOGLvak5KVvCuorO7t3MHw1ABwrLbx18EXViiHeXwAB?=
 =?us-ascii?Q?BvEDEvVQ4ZciVeOblbQawlDQK+vZmwulk0gkkZbhb9qStFFjDztOHZn3CeY6?=
 =?us-ascii?Q?Y3ddiNQm3l3SxHx8lW5xu3DdOhdiwjZ4sUPcZ+LjIpD7pBKeLAKSl+X3QDH+?=
 =?us-ascii?Q?wnXjrgai9u03Udd9WOVSDyFudxPRn0qL1GV/nLyVwzBfYTY2yscITKkoPXNI?=
 =?us-ascii?Q?3C8Hv4xtglxXPKzVL2kNBT2DxppgngsOgCv3Qmo2ivMftoNoDakgTOvGEkHr?=
 =?us-ascii?Q?V9aGNOM1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087202da-411c-4fa3-c669-08db20e53529
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 21:28:21.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBK0FpWq/sxo5L8V6kXG/kJzxK8RDAB79wxFlDAY8SkeQDYw6ExXLOi+U+DoxwhTc1a3Q/0FzcQGjCeoblCrd+I1ZiUo4Kt4DfZ95+uYSrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090173
X-Proofpoint-GUID: Wr_lZ7O1_5uT7KM05q6GawKFU7_UB_4e
X-Proofpoint-ORIG-GUID: Wr_lZ7O1_5uT7KM05q6GawKFU7_UB_4e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Luis,

> A big future question is of course how / when to use these for
> filesystems.  Should there be, for instance a 'mkfs --optimal-bs' or
> something which may look whatever hints the media uses ? Or do we just
> leaves the magic incantations to the admins?

mkfs already considers the reported queue limits (for the filesystems
most people use, anyway).

The problem is mainly that the devices don't report them. At least not
very often in the NVMe space. For SCSI devices, reporting these
parameters is quite common.

-- 
Martin K. Petersen	Oracle Linux Engineering
