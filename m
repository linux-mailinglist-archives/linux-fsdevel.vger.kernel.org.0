Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85F67B5E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 02:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJCAsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 20:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCAsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:48:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C9A9;
        Mon,  2 Oct 2023 17:48:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930irGJ021736;
        Tue, 3 Oct 2023 00:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=GSyxAsazOcsMNfdFMkGsy3jWCgiew/0II8oAPiT8IDg=;
 b=HY0eTsEjSiR+YXDgsNKTw1sVd3vpGHTysGv8JpRRh+JHPeE8siZRrVZDa4/V98nxtRt2
 fvpXWhEPw5WEaBYJNGONnTW8ZZiLHetbcGZZ21AM4W6muomlVkR62l6EpDLHf2RRs7bq
 uaO060qezzkYzziN9O4+GBMbe6k8bLv9S3zDCUDNcsmHuAjJa3DeHqcwt4/pZoekUmaV
 HfEKCzgitXC1LfRFrgFd5++9DrbnNChIL8RwLFmeox/k9DJfSYQa8EfLWvTx3nJTsatu
 frdWsfOC9XjduyiTtX+5RVroKMIZjZx74kbExdjHzD5IFq0L4L3ZxG+0Orv155k3wQ43 pw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcbpfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:48:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392NPo16033676;
        Tue, 3 Oct 2023 00:48:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45fjj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 00:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUNwBulyuO7N5+zfYmJzdAUTYFPtlv9Pc0JYA/WfS1fmTKgov7rtyb81B57MOxHnhkJ8W9XulzaMT/GO+1iAmQPGK+UKyPQR5en601CNesiZcj2DliS3549jGcUeJBruwUgwwNkZr4OR4aRMyTjl1hKrOai51/giA8e3LAioOYYHK5j7sIHTX44/SaXtXBcNS63Koqn1RIcJUF8qKWHzBMRYbKOsXWr4OktgMxvvE9cn+lIFwCab+uMeiLey2PsFTM+LnNbXC9zSFiqHK5Zf2qW0i4nJuFESdGS4TIM0JrPXNWBxSmoII8qzddJBIYg60BZ9elu6EbcXAcRJibyVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSyxAsazOcsMNfdFMkGsy3jWCgiew/0II8oAPiT8IDg=;
 b=mxn6xJuK/WE1hj4/FFhSvlIn5x+xLoiaZo68srgHpF1UsQY+4wismTknCJSQJlgbmL61YtyleUAiVDogH0ff6zB7/3ItEuFbPHASDEy9FR37cdaJOy2in9dD0I/ZcKrrMTTvEuEiKP4TDy7W0A90zffvgVCDE+L/p0sq4ooT2UJQhtsgjKjFl2FKPSE3XWoPRrMJUXzefeowiNEOlACzR23p3BtLq6bvuHewymHfBPjZrk2+R23CyU0w+y/b5LQPPUTtejwk4ekpcRUCVeEfOLad4NIxUmzu3WKtnzhgS/6JZIPrLKFhEOqzw547V9VgQ2TF97f9VUpeCJhbvqwteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSyxAsazOcsMNfdFMkGsy3jWCgiew/0II8oAPiT8IDg=;
 b=hCcx3Io3cRo0nfoRq1U2oD7A5/ARUeL57lq9TLi8gGUDDSpO+Hbxy6bpJSkUZMGeJYHOYdhtdCp9yi+MXDT7n10Tj0iUEIuEtyPKag7w3LxCgShCVX1QnJ1rbb2/bUMCED4Gz7Do1+iXgzqZJY4XshwSXHzaRfJqqrXZ8NuMqDs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5198.namprd10.prod.outlook.com (2603:10b6:5:3a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 00:48:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Tue, 3 Oct 2023
 00:48:09 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
        <20230929102726.2985188-11-john.g.garry@oracle.com>
        <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
        <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
        <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
Date:   Mon, 02 Oct 2023 20:48:06 -0400
In-Reply-To: <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org> (Bart Van Assche's
        message of "Mon, 2 Oct 2023 12:12:49 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0dcfdc-0503-4542-c610-08dbc3aa69c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: as7cWea8WZvO1YTivy0ynEEPpYwUt7Fv4sYWPQ5Qs0ZxiNolj16qBg6104rqQJGjCxrJqXVMU+baIlqomjMn64kPKXpAjArGuicIueTwVgGe4zBqiAp0E4phiB08WxkkZ469bC/R4I0XhUwbVACohPdUw5jYxD6ppWSH2EA8vwadyOyPx3NVvpQ5R2hPf25KUe9ErkTzr5xh9AUCPWO0zd/AT9eBQuEx754YlwZtChQ1YLFdKtB+jDmbaXNeOUDzGCVWNjf2xKMfBewCJk9u8uctGWzTKJpoasH5goYWbgD8nRNu7Bh37dHlKjpsY4iSXKETh6GMstUR/AhkW7w/2PNrFtYn4vTDNhi6Q3O6nri7HW58WHIeYkVTHqJV1j5OjVkxD3Tz86DGk9L/Pa8ecEY1j1BNB7hTkNHNKweOXp8OW5khC2RUAe9fJppXrLsa/Py5uY+0rz+vs6aFcnhk5Kj+rN5Dn+fMXP3Ln6lK4R/S9XBaRs02wqb+v7ZToH/VqiTj4tbrXymT8G2WbeQJr5DrkZDKbOCe+VWDSMWSUv5sdLYpvbJyIpxcd1FwVggP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66556008)(6916009)(316002)(4744005)(2906002)(66476007)(478600001)(7416002)(8676002)(8936002)(4326008)(66946007)(6486002)(26005)(5660300002)(83380400001)(6512007)(6666004)(6506007)(36916002)(41300700001)(86362001)(66899024)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KSGuefeC5TmV/ycCAsaVVocEUvYXJoo3wq4hiNJEQD5kCajtAqipaC+1l3PA?=
 =?us-ascii?Q?+5pDt6MAE47byVmufrq4O8UkywzWFuy5wzaj+0eH5fvjh2zjhUQA6QY2JsZS?=
 =?us-ascii?Q?qalYiZzTXLea6pWlJ3Vj54qlG98aRR7LJPx92+DRR8jpXn1HNq1QXagRyzJa?=
 =?us-ascii?Q?RBmG8+3TUT4OFqO+hUzNxosFKSgXKzTlAYu6OnVYgUEsnYF+tCMd2Zocky+w?=
 =?us-ascii?Q?9Q/4/sNSVtNLZ5SZBvGVLLlrrbtjvec+2fYQWBMBMiNJQi/CdIumQcLU3Pjk?=
 =?us-ascii?Q?Poq1zT/OYhxuXVOeSJEE6LtOD47pd1C/GfkkCCfm7oFtn9O2chefk9rHY0R5?=
 =?us-ascii?Q?LYqWiBa+aHSETJtweYlBb/nFAcsRnYVPzRanpf511jQHkMnCmhwLY/pRPzLL?=
 =?us-ascii?Q?7UEWMIYSuShyGuhPDArbhFHjRn4Zb28gGD54iM34hVlPy8WWPuDUOvAK8cIX?=
 =?us-ascii?Q?Tn72lBMO34Fz8NmLONt81KoDD3l/DU8OcAJhZ+LAu0ppK+bSJx3qLxmGR/E7?=
 =?us-ascii?Q?+5AKbykt8fj7ZPkOJNyt/am3rzHHnv1pAsVEHEj1yqMBaPY+AjynMRmQWAeV?=
 =?us-ascii?Q?yDyy9qNtrBk/D9PltnHRZ9TGadjVzf9ARVYjOoSCYZMm8K8vDEQStvvmX7Wv?=
 =?us-ascii?Q?H5sT52rplzbNMGrQgQ3EKTYnuhznpZuNihMK+ahyUcJra97aTxyl3NrJ0zcb?=
 =?us-ascii?Q?ZUO+atNxsZTXJi9lvg1df4zviIw6nBmf0FwSx+jkbvvrALSZ+NUnhKOD60DX?=
 =?us-ascii?Q?3MU2mNlHVwt+i9kPKtVD8SmZm1vE2xbrppqM7RIhT9UIp+OosClEowAf5oBQ?=
 =?us-ascii?Q?d4FMftnmd1J8x15JChMeox4tX7HiZgC3w/+NLDx1dPJ25z7CUqGOrNPSXuTQ?=
 =?us-ascii?Q?khbGJS1HscAPaoeHtKU+IOlB6NXR35gDaIQ50ZAtM6sa1pW6nQY36r73Li9A?=
 =?us-ascii?Q?Alp6Mpq4pTyi5P0d+AzwGXD/NQfszl00aiXSFkwwJmco94IP0Q1gCQfmHXyC?=
 =?us-ascii?Q?LsAAD+R3sj9fbAkdqQIhWwYY2+BZC5d9fkQTwCMxSSc4xR1zi0FyVkybYHlf?=
 =?us-ascii?Q?8pysn3lCBCKFiaJ0pYZ1e2nUZr6PtQdkkPnt1J/a3gDi5cPE3nZxIJ2g7Dws?=
 =?us-ascii?Q?4lThmDo4LlSu7sqmdkwoJsdlHbP2Nk/6dkpTnxSc/40T+psSiz/velSDcDRa?=
 =?us-ascii?Q?fEr0eDqjWdPCc88nNpzPTL62cJ0++bEyW8jW5i41ZoEYC9Xz7nTrA2MiOodp?=
 =?us-ascii?Q?SFQPAJTwTqj5P9BEDqyoENAR8Y5raMLj/Cbd5vmq5boaDNoLyAtjm2XIw007?=
 =?us-ascii?Q?NqWYkhzg9MgE3rJMT4q8lR5pTn643tm6h+O0PrhhoEkpQe1LTyHp6J51/0ws?=
 =?us-ascii?Q?mBPcKpMlpJ1Q1dJyJOLfPep03duK0eZplMw4jObSFs2yU8yhWMMoA8e3yBQB?=
 =?us-ascii?Q?KEX8b5HIZsDCiDK071bChyhIlowcAT7qjiTjB4SOtni/eg92YVqk9KhmEugf?=
 =?us-ascii?Q?TmvS0eRRMZwu47887J6j01iuZ1oNRwtGRT2pVly2GFRjoAnvZXb4ye4o28QB?=
 =?us-ascii?Q?x53ehmRZk1TqeNwjCSriiNp5B7a8io003l1x7Y27BiGpIPP6Iywqm0FwxqI+?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YWB9EumeY4xipv+kUkXlW1gq8gDY+5C9L+1UrFekSk7z6nZxfal9sKO5Q7hF?=
 =?us-ascii?Q?6SM0qIK/LUAmSz+gkU91btPCfxEm6Idmv2W/VNgbYNORGC6fSl0qyK4OFE8p?=
 =?us-ascii?Q?7Q8HG96geUDsFt8Ub2s2VsNBLg2EZFiz838Y75X9fTlwBh3PFSVfFmD0+enB?=
 =?us-ascii?Q?atJ4b1JGyW3cSWNkxm0m9CKYMnNTqRJ/1EzdglVINiQe0J01DoeR46Veu48b?=
 =?us-ascii?Q?wxa63wJxA2n3Ah/G0zZDBeq0c8Tic7WcDyzfG9EPqbWNEeKX+4B2IvkRsEBF?=
 =?us-ascii?Q?lS8Z295Mwfm524uZl6qvmzlPLnqs8Y790Pre+K6DzeWudD0ip2q+qXUykV+b?=
 =?us-ascii?Q?lfXs1r+FHUitl6Ep+pr4MR85mHEkgsfBhuEBCuTqlOHzrfejtlMzOUmbrR49?=
 =?us-ascii?Q?bJ5R5essfy1R6XvwN2BIzZLbZsQFN9gva0seZ0hI7KTjDXFvm43oHVVZHLrj?=
 =?us-ascii?Q?An4OxL68hTq4f4NmuwVm63LM9s4hjQqNgT5STssYjYMSH/vXLHrbA9gFB42E?=
 =?us-ascii?Q?48Npp+BTFqoOdJb2cBKotKBYFzkjHeQslH+bmHVasI44FqeESD0SZkT6exCX?=
 =?us-ascii?Q?Efsd9pmEuZbzKSHeLW1cN0+ZmCowA+cY3El329NLyoVl7bSlH+dPLPMntdDc?=
 =?us-ascii?Q?0hT85F5Omnp/H66eJ83pbTV+Srdk1daK3+Tj2hvzgl3pMjtnuRtcsDorEfM2?=
 =?us-ascii?Q?JudQDr/iE19nUBF+1VU601W7Ng0TiMzkqZwdYZ8usWNXmcXD7yvl0ItiZSuK?=
 =?us-ascii?Q?MnSd9JZd7UU0EvCBE6pp7uQXXhnv5wNbYYXsrKOmKcuuGm5cX8xiV1nJn6J8?=
 =?us-ascii?Q?etCiFJ8yVZXAyS+0qSY5sqQa2nRp8en2E/rh8nps4zZsiNZPHqhNRgDqPrPt?=
 =?us-ascii?Q?aHPzMj5jq1PTTvIanqaK3k/+h3tYELLmM7KwhQrZ3kyEyGFxC6ILddBUaIZX?=
 =?us-ascii?Q?MFYQjAd1aZRtGS0dNyUC8nNpgjfTP2+IIKkhgOXY97WDzrKQBCXOyoTMVs/v?=
 =?us-ascii?Q?OxA49H0LsDxOBsepCMyxCV/lIfUt1pF+rUk0QOkdJjiOn/irre2Ufd/M/1HR?=
 =?us-ascii?Q?SxtrXgVKv9S0YB41BtgnXDaZDj/4jlAupnwiMBTwf9Wcmb44gbI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0dcfdc-0503-4542-c610-08dbc3aa69c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:48:09.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axw7B8kpNjDFt4ZESZ+sJ/m/3Gm75MVPYKhjTt+zi0kmaOlHDypQlebmY7Qf0OFTbr7MlTiOTzPeOjaamPv0UsmCyz2OEvBTBiNhFdSJgps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030004
X-Proofpoint-GUID: MSKxjt690Mf4HYr-RHAnQzOEVHKiLFtJ
X-Proofpoint-ORIG-GUID: MSKxjt690Mf4HYr-RHAnQzOEVHKiLFtJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Bart,

> Are there any SCSI devices that we care about that report an ATOMIC
> TRANSFER LENGTH GRANULARITY that is larger than a single logical
> block?

Yes.

Note that code path used inside a storage device to guarantee atomicity
of an entire I/O may be substantially different from the code path which
only offers an incremental guarantee at a single logical or physical
block level (to the extent that those guarantees are offered at all but
that's a different kettle of fish).

> I'm wondering whether we really have to support such devices.

Yes.

-- 
Martin K. Petersen	Oracle Linux Engineering
