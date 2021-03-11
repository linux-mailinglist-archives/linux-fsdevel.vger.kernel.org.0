Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BD3375AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 15:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhCKO3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 09:29:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhCKO2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:28:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BEKfS3127632;
        Thu, 11 Mar 2021 14:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=sGeUMijq/SWiHDDhGTef7euLdnghuPlLAS7sWbZOeVA=;
 b=ybcJthE44Eovmr5m5AJSWngNetAEjrERZvh4NM+nNNHtzesnBjuIKiymh0n5EbD0YTbX
 OmhADG4tQ/XM7b70RkLZniNTYPlMLfh1hDBtAVtXHHmMPpcVfKMgMjcW9Px+grql8hh/
 0D99L4fL15g4mJMC0l9lDsimmzABRrz+c9PGnR3aRGI8HqCDzTyZkZD7KAECh3LLZxYi
 6/NrZd+xEWOZvFqYRSVe9s/zm+AnOofrjtQQL+0tQz0eUu1hHHr8/FrXWGvRGdOQdlyW
 VFPFkNKvO/1wRhYsTub7OGwMNezAyx96CVN09rCBZo7JfU6ESOV5ACaMpclmYXEF7SSV 7w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37415rerk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 14:28:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BEJafS176420;
        Thu, 11 Mar 2021 14:28:43 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by aserp3020.oracle.com with ESMTP id 374kn2ka80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 14:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nT4PBk++JJyJIP8JhvTRxOUg0wLT8P5dU51HDWl28loo1j2SNVbwMKYvvgT7NoM4LKRHmFSuCqqzBhGU+Jmcmk7ODm1nidN3+xj/s5ibHw9F81CimQQj+6fLhkh5lpRxG6xuF3O7rJDpNpPqSQ+oO/GuddrAOfKdP71CnJqhjvJYUpTjf4a+9hDJE2wO8AmpmBHOpiwSBekuQNawpu1euy7XhGsHWoM94LSko8JkePd9JcbOtCSyge17vbTlv4YEHS9zQqNr0AL/cZHfQj3IVrgy90IevhGL2PPEBmDwpcywCLkac11gLz39Vd2I7NE9mhHGJCRxe6cmFLrAjzEPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGeUMijq/SWiHDDhGTef7euLdnghuPlLAS7sWbZOeVA=;
 b=CbsGVrKwVi/u7R1klVC9DtTLALyNIUEfWONd98r4NLOOe1G/G0YgliZ+OzI31zSgBTDpX7OwpRDoAmzuR+zMRuJha2jZP4bLKbY0m5UqM3hLifH2WsvuVtHgc5JXRxC28wNTMcT2BwW+XhduwciifkAS7DPXn+jfE0coLys1/qc6rYpP56Ty7RnA7/GLJoo/l8/MORdaqXkYtCNVNFnUiISRjkpuLOgiXcHPdxgs7qdjtUAvO6EqfkNtxA2o5572e6ayg912keoLj0UA/RH6IbP9uyaMqAEE93L2y/FSVRt+Uw843jTW/Oa3CIjWzbfMG+/bC3ot0GwTQ8/IdYyltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGeUMijq/SWiHDDhGTef7euLdnghuPlLAS7sWbZOeVA=;
 b=uA3ElAwGoHirqUrwRa+chWrskpGqKUS6bgxzDiXTuOfiZ69ARysKgMOLVSR8m2VZxApb7iptSYi7dJ7+auolMIUUqW9AkdxMINpZjYSy7loHDXDuplEQSPWL1JRL4ZYbXu3gMS3ERupZ0VTNnnHCHYjX94t7aMqnR8bx+QL8JqA=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4549.namprd10.prod.outlook.com (2603:10b6:510:37::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Thu, 11 Mar
 2021 14:28:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 14:28:41 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: rename BIO_MAX_PAGES to BIO_MAX_VECS
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2et935l.fsf@ca-mkp.ca.oracle.com>
References: <20210311110137.1132391-1-hch@lst.de>
        <20210311110137.1132391-2-hch@lst.de>
Date:   Thu, 11 Mar 2021 09:28:37 -0500
In-Reply-To: <20210311110137.1132391-2-hch@lst.de> (Christoph Hellwig's
        message of "Thu, 11 Mar 2021 12:01:37 +0100")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: CY4PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:903:32::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by CY4PR13CA0003.namprd13.prod.outlook.com (2603:10b6:903:32::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Thu, 11 Mar 2021 14:28:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3be4030-a3dc-49f8-9d32-08d8e499f7b8
X-MS-TrafficTypeDiagnostic: PH0PR10MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4549F303DFB48BBACC6322B58E909@PH0PR10MB4549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ji8I49oIBT2+tEE7ZU/t5mRzQ133mlPzGp5w9hU9jSiZeIKBlSEMsCjNDruhLayvZrQ/Ztleo4MGFvdAHLy0xIylFXZi2mrZRfueoYegZheB2F5uy8oPq8mbX83CxRtCz9kQWtoue+ojKzcqyZV7OKKNDuZ6vH5OsfuCaC3XUWOxabisQ3c5otDZrbPJwfh9W3gtokd5P+X8caKVtYNWAIvasKkz7ocTLkDLaB8fJdRZSl4yVeKcnWkbBcvqIZ2dCMyOAHuUCJRLwhNCQia3uxOQca1laWom5uwHD4TZrMqQTwItvRLN2x5t1hj0IDZMhm7efavR/ftzl7YhUoguHyVCiS6LNYWNfK9D/ge7qpkF0IfBH12HQymSEHwljTxz2UlLpK3cUAV0lmTRQBlsZj6f/xgfIJYzV7NjaOzzLQn/yYe+e47fI9R63ODRt5wHk9yja8y8LuLp/neKuecLkkjKAgAJeXKNc3ILz6aV1g5PbTGcWBQpT4jCAFsn9yrpj0MZtRDiORzLfSKerePI1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(956004)(4326008)(6666004)(26005)(66556008)(66476007)(66946007)(186003)(16526019)(8676002)(2906002)(52116002)(7696005)(86362001)(4744005)(36916002)(8936002)(6916009)(5660300002)(478600001)(316002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ySWw+UjEOp51HDqruEedGEDInTy9ZBJJ8kuDCNauHZEokOxgc3NWA7dZDLqS?=
 =?us-ascii?Q?dKUU5RWjIKSkPWgDweL2m7DSLUaD5fN+CxvgCs8S2RKgOSkjut0RyYcbenWv?=
 =?us-ascii?Q?h2d+2fkXMjzlJTNxGiNT8xbD2WK+izdtWWGK2ZQ6ab4X8NJbAy8tdpGMJJIU?=
 =?us-ascii?Q?qT1SyiZlw6zY8JfbmPxdoXBbDu5MCijzI2Zi7v34sD83l3JLNpijEjbXB4I9?=
 =?us-ascii?Q?+2sQJKpZ9OCUeBTZftRAI+lyzuSJ30BcE7SzTAT928WsrX3KrYZPq0kk71kA?=
 =?us-ascii?Q?d4Yq99iauXttG5k+sennvvMHcIWmS+Cp0mLESQeJ3YynHwPlbLA0ZWkb8uQt?=
 =?us-ascii?Q?0rnQbzV/mbfg7aNbjmXkANNhYiBWN+PBEseyk0umFr8XeLpZiz6ucUX6h/bS?=
 =?us-ascii?Q?44dcRmRGTJIJi8wTp5Z0zSkwavETVdno0sIw2tF3zWKePlFvAK2WZ/9hjLbQ?=
 =?us-ascii?Q?0iDRyQ5vDlpdpVsSWLL9P91QfqO+Zp6HPTFGRQ3XJPPMGIcVt9ZgjabBDuQM?=
 =?us-ascii?Q?WF+E2+HIyrcdfbjOxyiyByyrUGzPcVqS8zo+TxisKoldZdEDj01IqpzOW9ka?=
 =?us-ascii?Q?Wx/eCg1lI8fCVwxfujwPrd5g281d4+f8WCGarjnI8ztbbceupiG1x8i2E+Mu?=
 =?us-ascii?Q?bhGD1lW6rF0TFcesY3t0QaO2gDLOOvr6d5bBRM13uGdGPNRM7bSuu8Dp2SY0?=
 =?us-ascii?Q?kd/n1j9Q8RaIwYPxxR+a8KWvQnVMXJBujCYByGUj5Gm0b/5SXCdnDbteCVpb?=
 =?us-ascii?Q?O0oWUyhBbs9cCMK3aYTTfUoUP/Zn5+jli/+tbHE7Y/CuUK8AZOrHLRn79E2Z?=
 =?us-ascii?Q?OaKWMsZnxMZAa6lzvOYGFqu00KyO2Tgzv0A637D9ROSgT0xQ2ZXSDNs/6FiK?=
 =?us-ascii?Q?oTRtTk2ptoOwuVqCEoRjQxK0GD+cXs2HkkIrcze4DOyH2/cQ/ui7YvCTRRKE?=
 =?us-ascii?Q?zxUHAMybcnZGwBmGrK6/eexWgeqhGZVkjP7LWAAwcTbt3Sz1p/xYs4NIgFZp?=
 =?us-ascii?Q?yIXSaPUCH5UG9hQ+mfvL3qKUGKMAWihy8h+0TPmO0onCSqJ3P0pM/w6tPXji?=
 =?us-ascii?Q?wYIoueXqYqTv8OWLWiYtu+WWwnYQcAxFqDRU21KiQT+cmsqcFJ/uJKAALFGh?=
 =?us-ascii?Q?qfzBAohkK6lC3v3h7TEK88Wuc5VlgoM0hfExyJL8ocNzV9suTQHYXxHHrJO/?=
 =?us-ascii?Q?F7/mJzd2PpTgSer/S9kGC8TGvL2W20T7pey84gfkezTMV0FrZeTpAOEFrukx?=
 =?us-ascii?Q?UzSkEILpRkXFCqPb+f/J7bHTjQvxLYMLdPtIarqL7IcS/sqljZay7OBXBJVR?=
 =?us-ascii?Q?0gUg0ILHiMSSHoFKf/YZjdxl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be4030-a3dc-49f8-9d32-08d8e499f7b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 14:28:41.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymZgGH3YIPqjcNRzsu6SDLh0NqGwxpzkoRRPNeOrnJEej+du4lwaSO6Y5spXRcSzD4ZITK00k2PF2JS48qv6V+PJgykPn6czw/B2kOYxTJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4549
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110078
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110078
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph,

> Ever since the addition of multipage bio_vecs BIO_MAX_PAGES has been
> horribly confusingly misnamed.  Rename it to BIO_MAX_VECS to stop
> confusing users of the bio API.

Looks good!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
