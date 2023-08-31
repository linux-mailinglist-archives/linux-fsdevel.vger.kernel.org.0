Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387C78EF65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbjHaOQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjHaOQr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:16:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F169CC;
        Thu, 31 Aug 2023 07:16:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDbRKG004170;
        Thu, 31 Aug 2023 14:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MyNFQScgvO4ULcpymaW8DMFEOJYDtiyGwWahT2UaMG0=;
 b=TZIvy2FA4xKTmKe4Pwitqsnx8KgyAFY7lvqrRJhiW7/qy9lIViFCJ3ytxki4LfSt80Sr
 G5OrScUOsjh1iRNNvhIXNc52h3rSg9skuxizoKcZJOiMviMaLcQ6yKpYc0rSIxT7YHgg
 ubtAiYah5WkHlPF9KoX7mHxlYZW4nxOUxibhiKpoQEGblVZVnbOayacfgwTLOIZZ57BS
 aRt9DVN++PubU/BU0d/DfeVzootapMnOSTo7Rsnb2Y32cHgY7BDWjE+hPuxlEXuI20tO
 d5jk2ZJB+Q9uHY/R5Ye91BidGJ0TdPxRebmBfdGAfTKJPjc5LJDDqhJpB5Uy1+Z+Evw7 ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk9wth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:10:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37VCsxI5009239;
        Thu, 31 Aug 2023 14:10:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sseq0d5yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 14:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCi5Hsr05KuG3PmlyiaUukvsxAu0Dt9dbq+nzJi4Z3zbmP/zNix1Pzu1abyRSWAesASaNzmR58UmJ1VIsZjwCLv9cbmD5GSYfbOf7tX8y0tfYJI3RoHuKvnCeoJRfa578i4Ug36E8DA3Zuo4MT5mO7oijewSGT1AHF3VJPPRLkbnEdaKnQcubVD6qHYBGcLNcoUufDxPMN5517wDOIw4ChFCtOprcnVQlzek+aLadcRfwwEcaxi17LgCCuCkNvMP5q1YEKKf1VCUDdLAcF/RrwmrzAAGyUsKyXlAwb9T2oZcL6bWDJDBoo0kKCFcHzhB6eAvZAoQWsyaI8ygRMsV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyNFQScgvO4ULcpymaW8DMFEOJYDtiyGwWahT2UaMG0=;
 b=gwPztpslklbCt3sqfl47Bbf1lzE3jTYZ81j1V6zHBHY1wbgNS+lpv35/Vqrw4h6mfsWnj1Dy6BWA65v+HARI2bRl5Y+a3GReSBDyqZ4h6eH1TtT1hlVBkRZyCVhSC+IXx9vWYri2l0fLJHPAXnMLbm2ThUX2tHaXswpnL2FoexUllLCIfeQJKy6gmgtE++7eWZ88QGaWPXL3UDdWwKfoNS5/+jT/7V6DJdYSJTYr9zQBebjo4Cpw6lZ23QsGV7+19TluEW+lseOxfhxoRxcfG+Ou7+CvIXRkK73OOhPYvhAz4AExnvqUAd9t429lB1kzaT88ObcvferKaE1LB0takQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyNFQScgvO4ULcpymaW8DMFEOJYDtiyGwWahT2UaMG0=;
 b=avmGdemyvIs4WOxQVPJyREMtqQ1LHyslxlYQwrjyzckMNHwEVE/96cr2Eg6HEaSjzURXIeQ+P2L5xLy337ZXEZaqnxHGM4MKRxuMHHKc3Iyki5/weQK72Y7GXf1HFhK9Fh6YTfpih8iu++Lo6Fj0V5vW0uPxBbsLHkVALbCVLec=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 14:10:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 14:10:32 +0000
Date:   Thu, 31 Aug 2023 10:10:28 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 21/25] ima: Move to LSM infrastructure
Message-ID: <ZPCfVJTEgKaGF61E@tissot.1015granger.net>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
 <20230831113803.910630-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831113803.910630-2-roberto.sassu@huaweicloud.com>
X-ClientProxiedBy: CH2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:610:50::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 01727050-98bd-4804-1f23-08dbaa2c09bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9i5kTSv8u2QUIgHs9QIhv3NNXiiLRK902Zq1RT6GH9EfTBrPr0vftXTg7m8IrvBUhC1YvKFYiVR7os+wrs7kCY0ZOCM5cPoWztsruPYOqcfuKoVWa5b3PtFDpyu+lQJ89Wb67YWOc/j12HTQM4v4PQ5CBCXIEQJqWelEbKVd5qadzKkPSRR7v6JNElx5h3ojoYeBRfNhoFRmnc/4lhqzUme6DIG1Cu+rV8+9d4kNTdg+Czu0QGhTTimAXs5I1hqWI7nbcjXqnQznoj0vO+EEoaGMmNPUgwB3DngKJN7F3JMoGsi719ZAfyzTHSt4to44YwwgRUaHAtdEEB5oxS0CRUd/Cdl4FFJXdLVL3B1E0ECRqZUikiiTgecSSlQLIv6HsjFDmo9RPYvPh/xPrdYBeEckn7P0tIyZ0Pem2hTEIH7HFf0nqMLAQcFyWfkBbXBjJVR4vBTR77wFr8ktxtNZCY3+O9649YMT6x0Hk8ocsFCmZiw8V9LglAt4q3FtrzNerkBepdAiDBO8FgK8HZAcO+YYnKUP9BfJIz43bE48A0sfBGwcqJwZwoIfTx4J1UH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(30864003)(7416002)(83380400001)(2906002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6486002)(86362001)(6666004)(478600001)(5660300002)(26005)(44832011)(6512007)(9686003)(41300700001)(38100700002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONko8ZcOpYfOY7TN1gVe0UeIA93ZTLkcR/rlo4g/xXkOqblKk+kTNGW7wSmZ?=
 =?us-ascii?Q?lAolJsxT8UI6PndlDAQ4Q90IXlmtra9aPA9nQ8LCO5+W8+ym8dkr8kBN0Ic1?=
 =?us-ascii?Q?tmCt4Q9GyU3G6Jesa8aBZOuOV1TBI+G7HWnr1pNBNL+KpTjHsTxho4X1W0gU?=
 =?us-ascii?Q?1665Y4I4dfWYrlebvrMSH+7RFjy9WIt2PdL2ATX0XIrTN9kQfwHwAKKh2wFj?=
 =?us-ascii?Q?Naizd58uy+L/61b1U/g9FEuKpg3Zed+OPDp3gEquafgGMuF+vi7fF7vhTMBx?=
 =?us-ascii?Q?MHZteKfWdOzJqimt05TU3XSjXUVzQngB0SOSmoJc6zz+QNwMjuCgFd8gDEjS?=
 =?us-ascii?Q?DZYQEIvqRid3YYCtXWOPVMqpfVnsX8tpSn40m9dZk829noiDQMtk60Xpmswd?=
 =?us-ascii?Q?BdHiG1ssMKLKm3rnNtqtIAgEwPi4rmSlp1cCDYvOgNA+sE6Nt0s7MD5lwLmJ?=
 =?us-ascii?Q?pFfnIXLm0XJ7rQWtpHWNOHl87roTW9G9B/+RJIY1jxjFO6dBR/ztPKtGEXrc?=
 =?us-ascii?Q?CiGF/FfcaK57HyGo8TyCg3ZzXx5nXb77QeZT3ozKIERWbPJxGklQt7Xh6lYr?=
 =?us-ascii?Q?b3MbKObFzJmEy0KEZsAi8QFa3OC303Ui6fawEFHSf70NJhTzebFA5u/Om/IV?=
 =?us-ascii?Q?pD7DALJhlbnRjLQccQdvEgMqtXCi/ZrhjlM66SerxnN1+gACB3z1AlNhZORh?=
 =?us-ascii?Q?Sb8mAH/QCt7IrP0LwN6t1nB2DfSeLaOxCOYwVT+93W4FV9fwHJCPwJnc4Np+?=
 =?us-ascii?Q?45XRyfrdBmArXY/eOXs+a7Tz/rfOlH4aDVfUOvKkxMVZ2eLnLVMLKSb+M40p?=
 =?us-ascii?Q?eWH5odvtm332QRn91vDdOE538yxG1bVaePT5FSZYa2VkLCDUBhPL0YPlTc9f?=
 =?us-ascii?Q?7ljHnZOVMrnY3nTRcO0IC1+JEZgPUMCHD7KorEJxapievZTvs3PwWoy5voYZ?=
 =?us-ascii?Q?ODGES61Z0RkjL3ym9OujwL7AgtDihWplQIJbYfcvKit/nMmnt4YA42YXu/vm?=
 =?us-ascii?Q?hhSDIfkehL8pjgiblmuKZkX5oMylbX0qI07waRrak3+1ZHt4tJKl1EwPwehJ?=
 =?us-ascii?Q?XakKCG445lfrs3/wD0aaWsz90CUSi1Aom+rqQoFC81DevP9zNcuWOcRjg82H?=
 =?us-ascii?Q?ZsvE4NCKpechxh99QT2fRfpvxmbS0+kpYRnIDQiJr1Zb5+k0ejY7vbcu/KTx?=
 =?us-ascii?Q?2rcvmrgJjWpui7Yhnm+0RJ6c37KF4LyDKyIJGTq10vQcI35m084VlGECoLos?=
 =?us-ascii?Q?AmwucQZRlUK6uIVwxev1MDcBOwerZZHw43SK5HE9x8oUhrdIGH1U2Q49Akhv?=
 =?us-ascii?Q?6qFUtQtZbpkKOSzRHLPnZyPpdgCT2el4YeOcODe+YFKHSGCxjbV/QykRomRm?=
 =?us-ascii?Q?2F3H2dQJ5d/jrqzrxiqMMJGgczBZaa06fwGfBgj/fkiP7lN2efdlFs9Vc/4l?=
 =?us-ascii?Q?9jsr26mYs/YQBfzu1TyppsTcuibWrpOIUxfubeEGGeX/Xy3Ytm7G+lL6txpe?=
 =?us-ascii?Q?kUYbaUr/LBxxlKrLtscsIngn9vcINcKTY4tCSybh3/qKfgWOr+xB56nnaSte?=
 =?us-ascii?Q?5TMtxcRi4iDJKE3baVKlcn6pVoNMY1Y43KpAa0IwoDlaI1L7o5sUlID1kdQx?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QDrDCmzikbtFL3PZIvc4tfRJsMa9mduI7Ecsqu58FJGA9oTTTQ0MMrkWPVHW?=
 =?us-ascii?Q?9D/oZvl7QJ744g1FzL8B9ATtzuPcasMu7APLo97MtghGyTFlOBzStpHxjwEQ?=
 =?us-ascii?Q?wZfFT0H2SMrPcTn+2cFfaIrBsvACe9QEjYPpEOCpyl0FQtWLvdFRSKE858Zr?=
 =?us-ascii?Q?oMSJfT+ZiGLK9VDAB24ApIaQTAPGvwsr1CKDB00FcUQ/U2UEHR0ZflmPlUAL?=
 =?us-ascii?Q?iEB5wfKOZn6UPejUZ9/jX3BCRtsPvEJAtFcL7I2psxfGMCHXM9C/6QQ0IE/F?=
 =?us-ascii?Q?vRh0jXWO9BT4lw8NXhmmWmiOsURcvtl7q+PYGp/TzX6mIIA1wRDrGzyFYxYs?=
 =?us-ascii?Q?9/A49SbGKSUT3PUTJhp7jtKzTlFf0V5Nx0QkTV25fd6yKX+2+O7B8uC/0FbF?=
 =?us-ascii?Q?LVvyp6sHnMPDU9OKU2AKreHx+NZ59I3NDJ8Afg1Ghjry2t9lBMVHA0najt2H?=
 =?us-ascii?Q?oMs5PfBnVuKO0RVEjczfT4mNqIqG0LVrrdlKZ6tGzrEbEdX+U27VybAyvNAC?=
 =?us-ascii?Q?1KjMuh8gb/Eu/A65LG5okcmo2t156JHc1xleaviX9oeGIEXU8rVysLvqfsAD?=
 =?us-ascii?Q?DBquv7Ikx3bVOBz5SIiBZQ0wPbdWuRXkTrYlMe2OjiktPJVnNQhjIizVBM8C?=
 =?us-ascii?Q?/PD1/p4mRLflWHMjbhKLH/3PxMm5wHvqGrdV4zodJLOiOYmtYdxj69l35tEX?=
 =?us-ascii?Q?xYb458PIPzTyINZdQTMNOt2HcxbMoDhfQfVcPqzYHE9LFuyWw2fPssEjnaFQ?=
 =?us-ascii?Q?9+sQ9Ahn9GtrVrbekL3cCMLyYum7kVc+fMiSrRrssBBrNiCQBWP+uopi+9WZ?=
 =?us-ascii?Q?N+OcTOFR0KDVCnIJcPToz0QA8DgiPSJUe0YCPBvlUKtFxu7SrpBF+kQujyc7?=
 =?us-ascii?Q?QZ8iREVm2jYVNm9l5BNX9oDSm6Xhcvz5P8bTxDI0fYv4abBlVihrsgwliIDa?=
 =?us-ascii?Q?5LkDDddsRtOA8Te16sDwF7Q5Ljfshx7pr0Mdb7wsikCBD2LaMfZWgB2Hc/Ru?=
 =?us-ascii?Q?6UDh3mbNesJ8iA0nrwBX2Sy15M28VMUzzD3QZX0D64dI9Yi3xylcRigsNa7K?=
 =?us-ascii?Q?fMqJ8/QyXeKrK/3R+Iiy73QCC1Gzf1msFejNjy4eCT6daJQfVJpyuqdTp2MB?=
 =?us-ascii?Q?mwA6jvk8tGITlIzTa6Nbpbmvn6WmWrqW5NhPnKzYNZBfGsBabVlynWlMCp9G?=
 =?us-ascii?Q?tw5hQk+NxsaLpNSBuZdEOXCDlj/3gtbxzxGSr3adIjaM2XJ9/PXB5G6IxC4h?=
 =?us-ascii?Q?ZBysSIkL81QqezVaxq0f?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01727050-98bd-4804-1f23-08dbaa2c09bd
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:10:32.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oquhNTaTiTRNr35GJeDlULy5HOrmhZtXR5YrVybzW6Lix55Ov0yxxLxX5rQd/5q2dT5G4Draqb0QvCqHtKsqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310127
X-Proofpoint-GUID: vehBq2g5lE3guaRCTRq4II-0WxhP99oI
X-Proofpoint-ORIG-GUID: vehBq2g5lE3guaRCTRq4II-0WxhP99oI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:37:59PM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Remove hardcoded IMA function calls (not for appraisal) from the LSM
> infrastructure, the VFS, NFS and the key subsystem.
> 
> Make those functions as static (except for ima_file_check() which is
> exported, and ima_post_key_create_or_update(), which is not in ima_main.c),
> and register them as implementation of the respective hooks in the new
> function init_ima_lsm().
> 
> Call init_ima_lsm() from integrity_lsm_init() (renamed from
> integrity_iintcache_init()), to make sure that the integrity subsystem is
> ready at the time IMA hooks are registered. The same will be done for EVM,
> by calling init_evm_lsm() just after init_ima_lsm().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/file_table.c                   |  2 -
>  fs/namei.c                        |  7 ---
>  fs/nfsd/vfs.c                     |  7 ---

For the NFSD part:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


>  fs/open.c                         |  1 -
>  include/linux/ima.h               | 94 -------------------------------
>  security/integrity/iint.c         |  7 ++-
>  security/integrity/ima/ima.h      |  6 ++
>  security/integrity/ima/ima_main.c | 63 ++++++++++++++-------
>  security/integrity/integrity.h    |  9 +++
>  security/keys/key.c               |  9 +--
>  security/security.c               | 53 +++--------------
>  11 files changed, 72 insertions(+), 186 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 964e24120684..7b9c756a42df 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -26,7 +26,6 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/percpu.h>
>  #include <linux/task_work.h>
> -#include <linux/ima.h>
>  #include <linux/swap.h>
>  #include <linux/kmemleak.h>
>  
> @@ -376,7 +375,6 @@ static void __fput(struct file *file)
>  	locks_remove_file(file);
>  
>  	security_file_pre_free(file);
> -	ima_file_free(file);
>  	if (unlikely(file->f_flags & FASYNC)) {
>  		if (file->f_op->fasync)
>  			file->f_op->fasync(-1, file, 0);
> diff --git a/fs/namei.c b/fs/namei.c
> index efed0e1e93f5..a200021209c3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -27,7 +27,6 @@
>  #include <linux/fsnotify.h>
>  #include <linux/personality.h>
>  #include <linux/security.h>
> -#include <linux/ima.h>
>  #include <linux/syscalls.h>
>  #include <linux/mount.h>
>  #include <linux/audit.h>
> @@ -3636,8 +3635,6 @@ static int do_open(struct nameidata *nd,
>  		error = vfs_open(&nd->path, file);
>  	if (!error)
>  		error = security_file_post_open(file, op->acc_mode);
> -	if (!error)
> -		error = ima_file_check(file, op->acc_mode);
>  	if (!error && do_truncate)
>  		error = handle_truncate(idmap, file);
>  	if (unlikely(error > 0)) {
> @@ -3701,7 +3698,6 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
>  		spin_unlock(&inode->i_lock);
>  	}
>  	security_inode_post_create_tmpfile(idmap, dir, file, mode);
> -	ima_post_create_tmpfile(idmap, dir, file, mode);
>  	return 0;
>  }
>  
> @@ -4049,9 +4045,6 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  		case 0: case S_IFREG:
>  			error = vfs_create(idmap, path.dentry->d_inode,
>  					   dentry, mode, true);
> -			if (!error)
> -				ima_post_path_mknod(idmap, &path, dentry,
> -						    mode_stripped, dev);
>  			break;
>  		case S_IFCHR: case S_IFBLK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3450bb1c8a18..94bbd7ac8b68 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -25,7 +25,6 @@
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/xattr.h>
>  #include <linux/jhash.h>
> -#include <linux/ima.h>
>  #include <linux/pagemap.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -868,12 +867,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  		goto out_nfserr;
>  	}
>  
> -	host_err = ima_file_check(file, may_flags);
> -	if (host_err) {
> -		fput(file);
> -		goto out_nfserr;
> -	}
> -
>  	if (may_flags & NFSD_MAY_64BIT_COOKIE)
>  		file->f_mode |= FMODE_64BITHASH;
>  	else
> diff --git a/fs/open.c b/fs/open.c
> index 0c55c8e7f837..6825ac1d07a9 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -29,7 +29,6 @@
>  #include <linux/audit.h>
>  #include <linux/falloc.h>
>  #include <linux/fs_struct.h>
> -#include <linux/ima.h>
>  #include <linux/dnotify.h>
>  #include <linux/compat.h>
>  #include <linux/mnt_idmapping.h>
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6e4d060ff378..58591b5cbdb4 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -16,26 +16,7 @@ struct linux_binprm;
>  
>  #ifdef CONFIG_IMA
>  extern enum hash_algo ima_get_current_hash_algo(void);
> -extern int ima_bprm_check(struct linux_binprm *bprm);
>  extern int ima_file_check(struct file *file, int mask);
> -extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -				    struct inode *dir, struct file *file,
> -				    umode_t mode);
> -extern void ima_file_free(struct file *file);
> -extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> -			 unsigned long prot, unsigned long flags);
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -		      unsigned long prot);
> -extern int ima_load_data(enum kernel_load_data_id id, bool contents);
> -extern int ima_post_load_data(char *buf, loff_t size,
> -			      enum kernel_load_data_id id, char *description);
> -extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
> -			 bool contents);
> -int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -		       enum kernel_read_file_id id);
> -extern void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				const struct path *dir, struct dentry *dentry,
> -				umode_t mode, unsigned int dev);
>  extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
> @@ -60,72 +41,11 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
>  	return HASH_ALGO__LAST;
>  }
>  
> -static inline int ima_bprm_check(struct linux_binprm *bprm)
> -{
> -	return 0;
> -}
> -
>  static inline int ima_file_check(struct file *file, int mask)
>  {
>  	return 0;
>  }
>  
> -static inline void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -					   struct inode *dir,
> -					   struct file *file,
> -					   umode_t mode)
> -{
> -}
> -
> -static inline void ima_file_free(struct file *file)
> -{
> -	return;
> -}
> -
> -static inline int ima_file_mmap(struct file *file, unsigned long reqprot,
> -				unsigned long prot, unsigned long flags)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_file_mprotect(struct vm_area_struct *vma,
> -				    unsigned long reqprot, unsigned long prot)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_load_data(enum kernel_load_data_id id, bool contents)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_post_load_data(char *buf, loff_t size,
> -				     enum kernel_load_data_id id,
> -				     char *description)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
> -				bool contents)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -				     enum kernel_read_file_id id)
> -{
> -	return 0;
> -}
> -
> -static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
> -				       const struct path *dir,
> -				       struct dentry *dentry,
> -				       umode_t mode, unsigned int dev)
> -{
> -	return;
> -}
> -
>  static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
>  {
>  	return -EOPNOTSUPP;
> @@ -176,20 +96,6 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  {}
>  #endif
>  
> -#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> -extern void ima_post_key_create_or_update(struct key *keyring,
> -					  struct key *key,
> -					  const void *payload, size_t plen,
> -					  unsigned long flags, bool create);
> -#else
> -static inline void ima_post_key_create_or_update(struct key *keyring,
> -						 struct key *key,
> -						 const void *payload,
> -						 size_t plen,
> -						 unsigned long flags,
> -						 bool create) {}
> -#endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
> -
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
>  extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index a462df827de2..32f0f3c5c4dd 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -167,20 +167,21 @@ static void init_once(void *foo)
>  	mutex_init(&iint->mutex);
>  }
>  
> -static int __init integrity_iintcache_init(void)
> +static int __init integrity_lsm_init(void)
>  {
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, init_once);
> +
> +	init_ima_lsm();
>  	return 0;
>  }
>  DEFINE_LSM(integrity) = {
>  	.name = "integrity",
> -	.init = integrity_iintcache_init,
> +	.init = integrity_lsm_init,
>  	.order = LSM_ORDER_LAST,
>  };
>  
> -
>  /*
>   * integrity_kernel_read - read data from the file
>   *
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..c0412100023e 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -127,6 +127,12 @@ void ima_load_kexec_buffer(void);
>  static inline void ima_load_kexec_buffer(void) {}
>  #endif /* CONFIG_HAVE_IMA_KEXEC */
>  
> +#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   const void *payload, size_t plen,
> +				   unsigned long flags, bool create);
> +#endif
> +
>  /*
>   * The default binary_runtime_measurements list format is defined as the
>   * platform native format.  The canonical format is defined as little-endian.
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f8581032e62c..0e4f882fcdce 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -188,7 +188,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>   *
>   * Flag files that changed, based on i_version
>   */
> -void ima_file_free(struct file *file)
> +static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint;
> @@ -413,8 +413,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_file_mmap(struct file *file, unsigned long reqprot,
> -		  unsigned long prot, unsigned long flags)
> +static int ima_file_mmap(struct file *file, unsigned long reqprot,
> +			 unsigned long prot, unsigned long flags)
>  {
>  	u32 secid;
>  	int ret;
> @@ -452,8 +452,8 @@ int ima_file_mmap(struct file *file, unsigned long reqprot,
>   *
>   * On mprotect change success, return 0.  On failure, return -EACESS.
>   */
> -int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> -		      unsigned long prot)
> +static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> +			     unsigned long prot)
>  {
>  	struct ima_template_desc *template = NULL;
>  	struct file *file;
> @@ -511,7 +511,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_bprm_check(struct linux_binprm *bprm)
> +static int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
>  	u32 secid;
> @@ -673,9 +673,8 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
>   * Skip calling process_measurement(), but indicate which newly, created
>   * tmpfiles are in policy.
>   */
> -void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> -			     struct inode *dir, struct file *file,
> -			     umode_t mode)
> +static void ima_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +				    struct file *file, umode_t mode)
>  {
>  	struct integrity_iint_cache *iint;
>  	struct inode *inode = file_inode(file);
> @@ -710,9 +709,9 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>   * Mark files created via the mknodat syscall as new, so that the
>   * file data can be written later.
>   */
> -void ima_post_path_mknod(struct mnt_idmap *idmap,
> -			 const struct path *dir, struct dentry *dentry,
> -			 umode_t mode, unsigned int dev)
> +static void __maybe_unused
> +ima_post_path_mknod(struct mnt_idmap *idmap, const struct path *dir,
> +		    struct dentry *dentry, umode_t mode, unsigned int dev)
>  {
>  	struct integrity_iint_cache *iint;
>  	struct inode *inode = dentry->d_inode;
> @@ -751,8 +750,8 @@ void ima_post_path_mknod(struct mnt_idmap *idmap,
>   *
>   * For permission return 0, otherwise return -EACCES.
>   */
> -int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> -		  bool contents)
> +static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
> +			 bool contents)
>  {
>  	enum ima_hooks func;
>  	u32 secid;
> @@ -801,8 +800,8 @@ const int read_idmap[READING_MAX_ID] = {
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_read_file(struct file *file, char *buf, loff_t size,
> -		       enum kernel_read_file_id read_id)
> +static int ima_post_read_file(struct file *file, char *buf, loff_t size,
> +			      enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;
>  	u32 secid;
> @@ -835,7 +834,7 @@ int ima_post_read_file(struct file *file, char *buf, loff_t size,
>   *
>   * For permission return 0, otherwise return -EACCES.
>   */
> -int ima_load_data(enum kernel_load_data_id id, bool contents)
> +static int ima_load_data(enum kernel_load_data_id id, bool contents)
>  {
>  	bool ima_enforce, sig_enforce;
>  
> @@ -889,9 +888,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
>   * On success return 0.  On integrity appraisal error, assuming the file
>   * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
>   */
> -int ima_post_load_data(char *buf, loff_t size,
> -		       enum kernel_load_data_id load_id,
> -		       char *description)
> +static int ima_post_load_data(char *buf, loff_t size,
> +			      enum kernel_load_data_id load_id,
> +			      char *description)
>  {
>  	if (load_id == LOADING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -1120,4 +1119,28 @@ static int __init init_ima(void)
>  	return error;
>  }
>  
> +static struct security_hook_list ima_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> +	LSM_HOOK_INIT(file_post_open, ima_file_check),
> +	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
> +	LSM_HOOK_INIT(file_pre_free_security, ima_file_free),
> +	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
> +	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
> +	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
> +	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
> +	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
> +	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
> +#ifdef CONFIG_SECURITY_PATH
> +	LSM_HOOK_INIT(path_post_mknod, ima_post_path_mknod),
> +#endif
> +#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
> +	LSM_HOOK_INIT(key_post_create_or_update, ima_post_key_create_or_update),
> +#endif
> +};
> +
> +void __init init_ima_lsm(void)
> +{
> +	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");
> +}
> +
>  late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7167a6e99bdc..7adc7d6c4f9f 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -18,6 +18,7 @@
>  #include <crypto/hash.h>
>  #include <linux/key.h>
>  #include <linux/audit.h>
> +#include <linux/lsm_hooks.h>
>  
>  /* iint action cache flags */
>  #define IMA_MEASURE		0x00000001
> @@ -191,6 +192,14 @@ extern struct dentry *integrity_dir;
>  
>  struct modsig;
>  
> +#ifdef CONFIG_IMA
> +void __init init_ima_lsm(void);
> +#else
> +static inline void __init init_ima_lsm(void)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
>  
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 0f9c6faf3491..2acf9fa80735 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -13,7 +13,6 @@
>  #include <linux/security.h>
>  #include <linux/workqueue.h>
>  #include <linux/random.h>
> -#include <linux/ima.h>
>  #include <linux/err.h>
>  #include "internal.h"
>  
> @@ -936,8 +935,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	security_key_post_create_or_update(keyring, key, payload, plen, flags,
>  					   true);
> -	ima_post_key_create_or_update(keyring, key, payload, plen,
> -				      flags, true);
>  
>  	key_ref = make_key_ref(key, is_key_possessed(keyring_ref));
>  
> @@ -969,13 +966,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	key_ref = __key_update(key_ref, &prep);
>  
> -	if (!IS_ERR(key_ref)) {
> +	if (!IS_ERR(key_ref))
>  		security_key_post_create_or_update(keyring, key, payload, plen,
>  						   flags, false);
> -		ima_post_key_create_or_update(keyring, key,
> -					      payload, plen,
> -					      flags, false);
> -	}
>  
>  	goto error_free_prep;
>  }
> diff --git a/security/security.c b/security/security.c
> index e6783c2f0c65..8c5b8ffeef92 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1098,12 +1098,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
>   */
>  int security_bprm_check(struct linux_binprm *bprm)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(bprm_check_security, 0, bprm);
> -	if (ret)
> -		return ret;
> -	return ima_bprm_check(bprm);
> +	return call_int_hook(bprm_check_security, 0, bprm);
>  }
>  
>  /**
> @@ -2793,13 +2788,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
>  int security_mmap_file(struct file *file, unsigned long prot,
>  		       unsigned long flags)
>  {
> -	unsigned long prot_adj = mmap_prot(file, prot);
> -	int ret;
> -
> -	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
> -	if (ret)
> -		return ret;
> -	return ima_file_mmap(file, prot, prot_adj, flags);
> +	return call_int_hook(mmap_file, 0, file, prot, mmap_prot(file, prot),
> +			     flags);
>  }
>  
>  /**
> @@ -2828,12 +2818,7 @@ int security_mmap_addr(unsigned long addr)
>  int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  			   unsigned long prot)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
> -	if (ret)
> -		return ret;
> -	return ima_file_mprotect(vma, reqprot, prot);
> +	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
>  }
>  
>  /**
> @@ -3163,12 +3148,7 @@ int security_kernel_module_request(char *kmod_name)
>  int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
>  			      bool contents)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
> -	if (ret)
> -		return ret;
> -	return ima_read_file(file, id, contents);
> +	return call_int_hook(kernel_read_file, 0, file, id, contents);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_read_file);
>  
> @@ -3188,12 +3168,7 @@ EXPORT_SYMBOL_GPL(security_kernel_read_file);
>  int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
>  				   enum kernel_read_file_id id)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
> -	if (ret)
> -		return ret;
> -	return ima_post_read_file(file, buf, size, id);
> +	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>  
> @@ -3208,12 +3183,7 @@ EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
>   */
>  int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_load_data, 0, id, contents);
> -	if (ret)
> -		return ret;
> -	return ima_load_data(id, contents);
> +	return call_int_hook(kernel_load_data, 0, id, contents);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_load_data);
>  
> @@ -3235,13 +3205,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
>  				   enum kernel_load_data_id id,
>  				   char *description)
>  {
> -	int ret;
> -
> -	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
> -			    description);
> -	if (ret)
> -		return ret;
> -	return ima_post_load_data(buf, size, id, description);
> +	return call_int_hook(kernel_post_load_data, 0, buf, size, id,
> +			     description);
>  }
>  EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
>  
> -- 
> 2.34.1
> 

-- 
Chuck Lever
