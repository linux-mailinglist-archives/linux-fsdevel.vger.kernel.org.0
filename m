Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071AC7BC39C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjJGBVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjJGBVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:21:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C9B6;
        Fri,  6 Oct 2023 18:21:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396LOv1K027285;
        Sat, 7 Oct 2023 01:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rIK8PNthw7jR8VfP37/YuoEu1vfIO3oTGBCGhd8uCMc=;
 b=RrIjdUoTiIAbg24w+fDQRi71HxNRBUMOc1yzHg9/8mU7jO7nSRJCv27CU0bGjOzIx36d
 MDHj5jneNVUIoNt+kJ2l8xyQhj8sP3rDkxg4wzd+s9tZBaXG5hz8B7iuBHnChVBxC8FI
 63QFuhDQZPZQVJ2WofjYPJx9aW/zMhWWfqnIPmSSFQVH3aS/CzMi7vo5WDpdCgCwvIWg
 kXi+uywmS7g3pLrCygH4BwjDvqGkDJ+20NE4s4mCKyylfZNGKeYiK1jw5LCch6HtxvUs
 D1OfXgzynCnwWQPAXcCthzv/hDgbCiPZo+CccKlMASPrbRL7GynH4SpnIy+ELALRSznB Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vmuxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:21:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396M6WxK002848;
        Sat, 7 Oct 2023 01:21:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4bb5h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4UW1DoNF0pUmsfEcAm5UWN65hB43RF4UtoEQROhT8q/BREvDBqc7eB/tlnw1WAkYA6LDEJJRjWpH1CQdu60ICdgvz8aOXgMfhDtBxKbZ8wt2xFEwC0wVFEw1gPMwysJA403V5wGkXjWXtgmqnnnCbgXnS3+MUhkRPYAOWE+EJjmt7oeHZTakpwI0u00nEJe8qbDwqAjYKvH9JTsQTi1k4oXmpCGBdqHVSRGKyEpzG6U1Il8Z7yM6HYnwXLVuCObg7GckfiHiqvRlC4nINfIGzsQE4iWMfNiLdIsGycLO094u1EDABVPnMVYcWvFeRYoNsH+bkDtO7bp0xKADpiJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIK8PNthw7jR8VfP37/YuoEu1vfIO3oTGBCGhd8uCMc=;
 b=UWrU0exc83aqmd9s4VDU/ER4A93YumWu1IhRNmN+piZcCH0Ah19KAwkGFoMHXGRDrfZWa2w371Y8dPtG2w3sESDq+SmBxN0+ZhdDbz1RtO9k/jW+87jTRAv+w7JaVOm4y9GOMctmUGt+/aZuOzfAY8a48Euvwq/7UGN/N+KxQhpvzT5Xl50tt4mO1aepwRQuRXTdgxHRURpkbyeexb6GbJoSHQPzSUAVkdDgOiLcsNSXmDbUUQz+mQ23u9ZSWHT+R9wDHL2hyoneDFwfSY9BL7ZAVerwMsZk3gXD/BSj//kmmc/uZryV1OmE3hMNsBXS4LVYiWR7pTDL/JYVGHiaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIK8PNthw7jR8VfP37/YuoEu1vfIO3oTGBCGhd8uCMc=;
 b=VAJExmUWQpzVHhZX3pF48REFQwEfEzPTYMuzJ2FLcnYb3b2vJND0YFKrX1KImNl0SsPRt3/ggjpq4W5K3AoosidBrFa58uqE9hVOdEbkyWFcVLQOHaCmkm5XmsGV5Q/RvmqEyNLXrO2oXGdf/t2oJJiNy6rTQ0KuOT/AP8Jg+Xc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4723.namprd10.prod.outlook.com (2603:10b6:303:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sat, 7 Oct
 2023 01:21:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 01:21:05 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8bjpaz5.fsf@ca-mkp.ca.oracle.com>
References: <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
        <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
        <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
        <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
        <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
        <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
        <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
        <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
        <ZR86Z1OcO52a4BtH@dread.disaster.area>
        <d976868a-d32c-43d1-b5da-ebbc4c8de468@acm.org>
        <ZR+NiYIuKzEilkW3@dread.disaster.area>
        <2bb2a4d0-4f1f-45f1-9196-f5d0d8ee1878@acm.org>
Date:   Fri, 06 Oct 2023 21:21:01 -0400
In-Reply-To: <2bb2a4d0-4f1f-45f1-9196-f5d0d8ee1878@acm.org> (Bart Van Assche's
        message of "Fri, 6 Oct 2023 10:22:08 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: be72003f-dd07-4637-16f4-08dbc6d3ad15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZafzDzlPaH3JtINiokgetvNu4064tpGO/utw7w8CYlANt5H5BJTqLJ3SUFSNCw2gmdngKnEaSFeyZ9uDENZ7phejCrb5Sl69Rpd420RkfsOpAhTIqHPwREieRjxnffwhln4vzXeks0P8DYUGl65nsCnVaek+kiYjxG6sAl8A7udVp3P6ow/nDF4j6As+FMrkcyV17znLl6Aq7Se5ZK8d1s+XHJALb5bnGd3/gDKcnE9LLLBS5b1uiv7M+hNwBPnHsHrxZffKSojKSRN6lTe25BVAMUDoQcRSjiDbQtrQHsgKugclYDi8epEgEhDNEfm4/4o7pIJd/1pbcR/JtLa4Ur2Vzmta+ic8r5JSOFqgPYmvirehmLtrNi7HV9nC0FCQRbAPu58LVEoQc5f4RfNNH+mhUtG43WypCsRKOe0OhW0yAHq4o5URpkXpKDPFPSCE19Fk5EdnDcYYv2i+e/9y7tOsgS8+as/BtNizLNq1lH7kbh651a3LjRU1mMCcsD9Tpw2PoWFwINkSjT9ThDCMadrHdui6hLGacX/ztExRBB/LrrXjLk6tcoMS7peU481
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(6506007)(6486002)(478600001)(36916002)(83380400001)(5660300002)(6666004)(38100700002)(86362001)(6916009)(2906002)(4326008)(26005)(54906003)(8936002)(41300700001)(8676002)(66556008)(66946007)(316002)(7416002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lr1Fzinal5iFPnKt0k8/VGcG7fdIHJcuzrw/VIT41AMu9cSPFSp984OYPJwt?=
 =?us-ascii?Q?1AIRyQlekBfMarznW+JCBZ6MOsEQlxkBzauhx/r9An0pSmr/arW9Lf5PEfOB?=
 =?us-ascii?Q?Ghkma/+hfTzKJJYtYvws+ClQtOc/CjTsEN9HtXBZxngVjfi26/NYI62YuOkd?=
 =?us-ascii?Q?1lJW/maj6hgysnuGNVlhos6yYsbbE0yxPf0284S7yADG655o1WsyTgZIsQtw?=
 =?us-ascii?Q?XBeIGBHBGEYigCCZlnp8Jr7njT3EKI9EovYsm8dsrZDKjzFz5Uu/62nCFZRx?=
 =?us-ascii?Q?hdRSJaBCHZCE1QMM6LRnxGIXJr4WYWgvM4Bl12VeejJJTjft2ETTzSefeFii?=
 =?us-ascii?Q?k0ATJxlmo8iKemfcyzzgDqs/lxjrWiJVMH7aGepMnlizNhJP2fUjA63lHgjS?=
 =?us-ascii?Q?77hIX3TmtHGP1X6JMVSbkaKyxkggrU27exnBfwACCl42oaeQTO8MKE5Ur/55?=
 =?us-ascii?Q?dpUiS5gZJirUhJnNAHTSwo1kLtw/L31+2IP53FtKthYs1F13F5MBKfPO1T2o?=
 =?us-ascii?Q?fjxdy3GhRkFe2xZI9Hvn+Wbjpl5lOAQnJ5VsHM0l/pZfwcXr10MDDHA7VBWH?=
 =?us-ascii?Q?o1fU25ptJUkMcJFgS2oTOdZoco124YS26wWRO+wYlm/lSXqIuQHursh+YLXc?=
 =?us-ascii?Q?cZ4j8W3ZBjATV9yc7RHFtTn8/ZO5QcZCW1YrO+acDhkQv2vUGs0FgnAc5Pqb?=
 =?us-ascii?Q?yCj2yz4hbsnfeYwAXhrf9Rio46FIR0sdkabCEpHpnWqCeloxvB1pNnBIDQ82?=
 =?us-ascii?Q?6Fqrg73AjZayR2eSXf5DUqwNNjLxAf/kNLf1TteL8/PnzF+4SWKcFcb8Ps8Q?=
 =?us-ascii?Q?gjnp9KAWDMlqDjDjll4boHOhtrDLXh0WQoy9SoMrswvqrPoHuePGVpQZLy8H?=
 =?us-ascii?Q?IwXA8s90bCq4382RZRMOY6xQep+XmoHqcaiV3xMnbpr+JfdYXLlMCAXcSZjU?=
 =?us-ascii?Q?n5GIzFaREpIe1flB5oGQfCtehW5xZN72M2schix7e5xKs+pKmL5tzKYqr2QR?=
 =?us-ascii?Q?PWgWwlIPMRuxxhXa6DHTIAXpowjgi9tACpc29taIYWs1mpK4wxn8wpkwmHkt?=
 =?us-ascii?Q?QQvlVPaNhPvsWUbsbgbIsxdImIYgg62FdeiTIRrh93Gh/lLcuSQRmjkiqpXl?=
 =?us-ascii?Q?TA5z/uyPxzl/6DwtrpDtn3mxLlrUL3yg0OZbzbmqUssUyz+u9KXMhY+eu3up?=
 =?us-ascii?Q?k/1bpccZSE/xWcn1GQkhfAfPr7vD/qKMBKnWinzT3mfdJPFfKOqC/QY32d0a?=
 =?us-ascii?Q?EM0gyYwSx6Ga14N6vant5Gye4AAZbSQCKu7zhTzzTiu51KfFBGV6N+rLbcv+?=
 =?us-ascii?Q?jEVpFzcmAmqTdUT8Xtg1st9zpCudJCWo0vPvovkgLI5nI7iq9f9sXIfvwMxU?=
 =?us-ascii?Q?GGnKV2JKHylhb4jAe8RXBThqRlyu+IcYp8JDdW5/Ru4e3BmJ4cIRF/6hH6L8?=
 =?us-ascii?Q?aJkARqw1iEXWXLVTXv709hMo8EsNHFOYBdsEHDygt+GLoicjdoC8AN9F4m+6?=
 =?us-ascii?Q?qDB/ARoEBmLeGYuzU1TbS9+FYpGupLt6MSzhO3jEay4w5PCl9O99WYKHMW3Q?=
 =?us-ascii?Q?Y+IA3tTk8WpiFMgRKg90/GsoRSYg0f7/XDZ2X5IoEge8jrGSP/mJGL+m4ulM?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+OBehmAcD3hA0p6MrHUCW3AZ2LCo5Tp3fgtvINqyEbtwMfpxVS+gsof1xqnh?=
 =?us-ascii?Q?Nq89ipDlg6IG5kCzxi58hLSlTv8ICrZee120oFIug6ADLNCiLaOwX+lzqGyI?=
 =?us-ascii?Q?wuZi2dp6KS2LCp02NZ1/jMFtoxSoE+DS8vooQHxOB1qoORCMjyt3W2v7IfhT?=
 =?us-ascii?Q?aoPuDkaZrSLcpgabudBGLCztZpsa+/hQQQegTpkeZ8n3/bcBhZnU+lHX0FbR?=
 =?us-ascii?Q?mhLYzEqrgJi1xAlb51qPCIzSAQi78ItudLePpw6Gxdmn5AvPRFt9562N8Vg/?=
 =?us-ascii?Q?gcVUi6eShZAoaoglU5XayBG5z1Gl/CCbc5InXryvhvumvOgP1tor9vXa35ZQ?=
 =?us-ascii?Q?g7BV4LlzCpsTDUtaOm7olw2n3cswJlVSSsNJXL2qXQN+SesTm0l6vDx67+ER?=
 =?us-ascii?Q?uP85KwGSt7mF9648FxuL+f8JrQK6jB/23Xh3d/phM9Q/ZN/Ux2/G6c/MLorw?=
 =?us-ascii?Q?nT4Ck28exiAyCk7TXWDzk7js6odG0oVxwc94tRtpxqKBe5Kq+sIRFGm0ZXi1?=
 =?us-ascii?Q?FmdveVWQhoGr0OHB/GMIqW8w1/+TZQJCAJnaSP5ryyYZ4fRZCf2sosHuKF5u?=
 =?us-ascii?Q?HPAglldVpgvrbcE/MVSxbeuUOnmbP08y8fPFk5CTrI2ADN0Q79mT142vVMGr?=
 =?us-ascii?Q?qvZQRDKQADOndznIrO/hQNRyUAn+khK+D3g3AjBu+BdY+c1whKu9Ivztapqw?=
 =?us-ascii?Q?a+joY5x3yuhTMUo3BPirYbOfuatx4m5M5aNGqywHX9+Oj0QzwtunziPknQQ2?=
 =?us-ascii?Q?aGbeJSN9v4QZhCGqwSBbfREuB3D3bSYK5UTVJI3T8JWik7XAqH6nZc8eY33G?=
 =?us-ascii?Q?9kGLXLe0d7fwMKKFBV4C2i3zoC8t4yvhOKa5v0Zvlr6NdzV023ahREf90LSJ?=
 =?us-ascii?Q?OoC+hqISdKwgWjD3ijQXO06zRIBwdZ2Qv9/hVfAH+/J87rijz6yxqHAirJy3?=
 =?us-ascii?Q?fjyrJUmSgHA0EXTMxh4VrS8JznAKI444671SvIpcKwNsXhJkBtv1VileTsBP?=
 =?us-ascii?Q?0IvFHgpn3PcWcHFPyyTm4E/CkHhPDgvcIQ+x3AuaTEjJjch06BNHASOxHjPM?=
 =?us-ascii?Q?8tToa8RTY2TlCEIoYqafhZZYMBHChZoEPoA/t1pmIPcNGunY4UfMGORTNaWm?=
 =?us-ascii?Q?pZR6/n2sQ2R78VVQ3cKawm3SIiPD0A+y3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be72003f-dd07-4637-16f4-08dbc6d3ad15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 01:21:04.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J03RGdSiODHXBtst2jGEjYyyniq3+PMuvUmsW+uH3AoSoyzvk77OzwutfFd0a+1XRBRMGF951KGXxijG4fYGrmpQj1Ze8ewoCOoqOCgXNbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310070009
X-Proofpoint-ORIG-GUID: xfE5TN4amzWvVkkR4AN_Bgag1VWsvMg-
X-Proofpoint-GUID: xfE5TN4amzWvVkkR4AN_Bgag1VWsvMg-
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

> The above implies that this parameter will always be equal to the
> logical block size.

It does not. Being able to write each individual block in an I/O without
tearing does not imply that a device can write two blocks as a single
atomic operation.

> Writes to a single physical block happen atomically. If there are
> multiple logical blocks per physical block, the block device must
> serialize read/modify/write cycles internally.

This is what SBC has to say:

"If any write command that is not an atomic write command, does not
complete successfully (e.g., the command completed with CHECK CONDITION
status, or the command was being processed at the time of a power loss
or an incorrect demount of a removable medium), then any data in the
logical blocks referenced by the LBAs specified by that command is
indeterminate."

SBC defines "atomic write command" like this:

"An atomic write command performs one or more atomic write operations.
 The following write commands are atomic write commands:

 a) WRITE ATOMIC (16) (see 5.48); and
 b) WRITE ATOMIC (32) (see 5.49)."

You will note that none of the regular WRITE commands appear in that
list.

Now, in practice we obviously rely heavily on the fact that most devices
are implemented in a sane fashion which doesn't mess up individual
logical blocks on power fail. But the spec does not guarantee this; it
is device implementation dependent. And again, we have seen both hard
disk drives and SSDs that cause collateral damage to an entire physical
block when power is lost at the wrong time.

-- 
Martin K. Petersen	Oracle Linux Engineering
