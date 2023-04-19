Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5E6E7B0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjDSNiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjDSNiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:38:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FB16DD8;
        Wed, 19 Apr 2023 06:37:41 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBcMsk025475;
        Wed, 19 Apr 2023 13:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dG4+B2ZIgmD/lEea+i+Z7fUXGEl+Ti+oi4LZJ6T+r78=;
 b=yk0iS48+frB+vF2H4XnT/r27LeqAw1hthz7VfCM0KYkUsGfD+57YinT6eQQGywjgJz18
 TSnl6POdsuZmBKI4kfYeQRfkXvZNRPWd8aU9Y0zELHA9p3t7SjRX76tOsPQuhKUs8G3q
 lRBPBHcRWGFJC8ZgahfQ3n33RwdkGmBvoifM3bEL/080z7NJAq7e0ommK0XonPYy+foZ
 np3W1GoFi5SmqANiR7otv2caP5bbXFdmASVQv2b4D439QdXOax2qPb28jGrU26g8PsWj
 F4DDeE8BEZpX9d8tzucqltnKkUGaH4mE6wFULvpDyxI8Gj5QoU6UlinOytBUpgHmOayu eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykyd0brv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:37:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JDPmVM037073;
        Wed, 19 Apr 2023 13:37:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjccyjx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:37:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcDNZQkzb8Yfiu1orndhvERxkhyYsLYWUaS0LSoCGKXZMt+z58TfD4vypGJS0Xox2JoqpZDHA6p0BWbti9PqiPCq7kSYmrtxCweVzyFIllNJjFHQX6RYr2h1vE55ZsbU3kprSaIeZxeszk5Ayg8qMgplkZ2N6awMLI7ApzTaWG0Jx4POtZdnCtjXcWFMMsTVq3Bm5Tmz/Nj8CKBJ5CDo4Kv6j+53CrZq2QIWvPk3mkcOMQSpkiuCVUsNEyKtEXrWy+VyCGmgnY3nqE3EdQOs1JVO9nYZGUAn3bDZ9taPLtW0f4Tyu8nVyw3dQrhP+JXcs+busrW5stbSC0n4Y7Ku4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG4+B2ZIgmD/lEea+i+Z7fUXGEl+Ti+oi4LZJ6T+r78=;
 b=i0ZP+iJaEdhVOdrjCmknCwXGBWIu8SzTeDyp+MphEBrJ0dHwPXV5SckuJw0STSGAiao7y5uukxbWGXUf8DlxyNAhxjcRLmw7u5Re9wjrzTw08uIYiGbAnjvaJ+FpsTwAFf8RaTCpiQbzgigqIdBqp5kunvdElk1L14te6iLqLY7dBOgBi5wPtuncejQ8NGcqXik0hiI7w4D7JNy15UT+5/FMNq/UnoPG9h9Q/WDSzTwX09Tpukc39okuI9+daGIRk6Mzkyx+zWZq7R3cpm8Y5LCm5p7rOLdkaeSYhso8Z12Z1L0Ge4WQaPJHVTY1sf6PnKv7PHx1AJeMYICfrLjQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG4+B2ZIgmD/lEea+i+Z7fUXGEl+Ti+oi4LZJ6T+r78=;
 b=Gy1ylAIwBJB1oHwzqcV9L6oQP64tipTXsK05drCHn5bqzN+a5jT5OOQmqYZr35lggzlfjaKmTr6FoZ78+jrksjC7mHeTfOUjhoZ7u/yyeJbdiHQDUokVQGTA0kxkZJbT1bhgLyRIQBQpjU7yExg5+yk6m5Ni/J71+Xy4yTiJ2IA=
Received: from SA1PR10MB5867.namprd10.prod.outlook.com (2603:10b6:806:22b::9)
 by PH0PR10MB6960.namprd10.prod.outlook.com (2603:10b6:510:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:37:34 +0000
Received: from SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::1827:534d:7d96:20f1]) by SA1PR10MB5867.namprd10.prod.outlook.com
 ([fe80::1827:534d:7d96:20f1%3]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 13:37:34 +0000
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
 <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
 <20230419021146.GE360889@frogsfrogsfrogs>
 <CAOQ4uxjmTBi9B=0mMKf6i8usLJ2GrAp88RhxFcQcGFK1LjQ_Lw@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Date:   Wed, 19 Apr 2023 16:28:48 +0530
In-reply-to: <CAOQ4uxjmTBi9B=0mMKf6i8usLJ2GrAp88RhxFcQcGFK1LjQ_Lw@mail.gmail.com>
Message-ID: <875y9st2lk.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To SA1PR10MB5867.namprd10.prod.outlook.com
 (2603:10b6:806:22b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5867:EE_|PH0PR10MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 522f1918-b2ee-42bf-0326-08db40db3b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OwmWpiaaCFM99I3dPmu5hvG+WJhCMdjAJAMdT4bsyKlVpU3m5Kkum1DEZgKoOjjKj2QeuinWmM7I+guAQgbJ13E4GIgM4RPfAeV0XdRlQESk0gYwczHkM9pIBiRfD3DsvCBaAk6XkypMQSthS8FDS0JgxRJTSGxttVqTeXAMB/Hx5gJ0DS/IdIYBDrAnOxeKlEQ8PliYU/1XgZ8GIj1uJ7hL3lkr54Ij2t8cQLB88sUwU/pjB/oXijyVBeLhruJCXaa35TE3Q5rUW1ECmRVD55PLcp+JPZ4ezdK1ghwHxPOa90bKNye5htLxLaihKKuGC9zBpj28xRUR7NU5wdXSngDkr+JrZOddU15rTZBeDPz5cQjlTozImq5I6zuevEFwA01XZfUeb11S+3zH77DdGPiL4PYs9WJtxGmHeRaWVoF0ufMCkSSFxmpM+rIcYjkIp/r7ndgS9mKNM4H3Lx8oZFTK25tllBZpfXYJ4Oo0vD/1+lI4YRSyVtvfTQyOEYhnHetqud/kLhQ6ESkSiX7qz1InWxjZ5eNQ6JyZE+HfSObPWnuIUmacT4JOtdVh0pA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5867.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(66476007)(478600001)(6666004)(38100700002)(8936002)(66899021)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(54906003)(186003)(107886003)(2906002)(53546011)(6512007)(26005)(83380400001)(9686003)(6506007)(86362001)(33716001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGowU250TXlHME8zVThmUkVQY1VKeWhDcFVYaEtLNnAyVVBFUElLUFZ4NzBR?=
 =?utf-8?B?UnhYOFQzcVJkTTM5YWpJb21kSG9Td1QyVHVpY2FXYkNKMEhwVEdIRkcvOUJ5?=
 =?utf-8?B?MStDejBNODc3U2E1S3k3dEhiUGdCcDkxR0diYjVNYWlabnM3TUcyVG42Rkox?=
 =?utf-8?B?MVlxUEYxcjNlRG1WSXAvMEpDKzdFL1VaU1ZrUDM2NEI1VUZmTi9ZV3h5N3BX?=
 =?utf-8?B?WjByT3ZkeGg3SU5sRENRNDgxdktucmV1aTNZQkdVdnVVSE9hQitubHlqZklD?=
 =?utf-8?B?R0IyaFIwT2lHbDJrNXhQcGU5WlZVcEdUdXo3ZklCNzVXUTdsUnlVNFl0Ky9U?=
 =?utf-8?B?RkxhWG5PWkl6emFLYWJBL29vNkw4NTloSTNMcXFrMGZ6cXBSaXBRREtzbGFP?=
 =?utf-8?B?TDV4YkdydUdOS1ZQMWdIQldDQlVBc01mWE5lN1hBOG9QZ0dheDNmZHFFU2F4?=
 =?utf-8?B?WG15NXJ6bnpjZEQ2ZCt4SGV3eEQ5Szh0dmVPOEI3N0d4WGNzSWZzWmlDbW1u?=
 =?utf-8?B?NzRNc0hlRTlxWTdOb0VZU2NvTC8xbVg5RFd1OWc4OUdzc1pMVmp2Ky9TUUVt?=
 =?utf-8?B?d3lSZjlzbENlM1FSdE00L1NxbVB6QWRPYlh1TnRHTEhaZXRVa0tVMXZKaDli?=
 =?utf-8?B?eThFUURUZXVOQnJsUzdPUWRJUGNqSS9qY1hQTUVkMnBNN2FDMWxVamN1MHJX?=
 =?utf-8?B?b3VRY3JiVVd3NlpQS2VrdTFNdzFIZVlNQ3VLUU16UGdBUDVYT1l1Y1hMYkNO?=
 =?utf-8?B?NENqMVZNN3Z4MHNIMlg4K1dlR0lsTnZkb1FyUFkyNktzcjBYSTh1QkF2TmhL?=
 =?utf-8?B?M3h2SzBQRERVOWRLMzMvbUcxaWhOMWFrK2Zmbjd5dmpYSjNGcFB0Z0llM1U5?=
 =?utf-8?B?bkNSNFhXNXMzUjlwaGxzamJBZ21LbGsxUzIrWWNvakYwTVFmaUJ4SmEzc1d2?=
 =?utf-8?B?SmJhWmdRL1RCSHdEb2JiQTdPOXBwTkhudGNJdHhQdUgwUVEvRk5wRDhQSUd1?=
 =?utf-8?B?OEZnZDZUYmozVmIrdnlodjllZ1Q4ZGw2UkkvK0trd3FXREVQNTlzcW96TjYv?=
 =?utf-8?B?aFUxTFZzaXFkb3Z1RE1kQjhxbGVuUkc4ZE1uNzV2cFFQaUtaVklzTUk5cEo1?=
 =?utf-8?B?eHNHeGRxeEFONWxVVlYvYWNtc25DNVFJWE50U252TnlWWE5QMXdLMmZwUEFQ?=
 =?utf-8?B?Mmo5ek5hR1pMbTg5TXlPbVhVOU5lMUtWSklEYmY0UTd0RkR1NXM1WmpMNEZj?=
 =?utf-8?B?R1VETGp5aEpRWU1MZE04ZnRoM2J2bzZYZitpaEh5M2VDOE1Xc3JhNXh4YmlR?=
 =?utf-8?B?ZUxIcjFpa3R0ZDlwcVZ4NE9uaHdzRWQvdms1SjBFTjVGZENrRnNWZFN1SWNl?=
 =?utf-8?B?M1pmRDRlbGYzNXFwWDdFdlVQNDlqNTRMZzU5Vmh1S090RitBaGNySHBxSGJZ?=
 =?utf-8?B?blV1L0RkZHcrelZMTy9kWGsreTdhRkdmNGdjTkxDQ091WWxFV0w3NytQVEFQ?=
 =?utf-8?B?YXo2UkZOdGYyM2dpR3hOQlkrLzByd2xBVEVEc3IrNWJINVRwaU1Xcm5KTElE?=
 =?utf-8?B?VURKejVuenMySlVXcjNGcVYyL2w3T3l6UGlxc2JHN1gwcnM5WXZQZjJtaHdP?=
 =?utf-8?B?dDdaMm1TcnQvWFBqNG8xZkY5aGRzR1pDV2VGeVlmZ2lCa3Vma0lzU09vUXNz?=
 =?utf-8?B?N0pTRWhhdFZPQldLVXk4eC8wbkY5OXlIT292dFd0eVlPR2hESWE0N3E3V0xr?=
 =?utf-8?B?c0U0Rk1aTHh2cWVVeml1RC9Tcnczb3VlcW41ZW5xVGtpaHdpZS9yenVUYnp2?=
 =?utf-8?B?L1A2UTZnRkl3aFdIN2kwREpHVEtZTG1semcrMzBTWEc3ZklzVlRyenRDODdU?=
 =?utf-8?B?K1dtSWJJZGxFTzFEdGNqaTVNcFlObEdEL3BHQ3NWTkRNcG45cEtRRFVFM2Rj?=
 =?utf-8?B?MjV0b1VjRmhZcTV6NXNCd1Fod2xQcDlRcGZPS0c3aVU2K0lQamVwTy93MGxC?=
 =?utf-8?B?WU9HVEJtZkZkRGpIaGdoZ016K2NaSGQwc2tvOG1HUEpFL2VPaDlKaW5mZ0Ju?=
 =?utf-8?B?b3I1eFc0RFFoaHZaV1lpNWtCTmo3eS9OQkMzUExYMzUzS3IxbWczd2dBTStx?=
 =?utf-8?Q?/Sb/JE4fBIZNffljN7OFPFvZl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XUrhLtEBZwxNivtTBzg/JgTQt2aZUGY/6n1FwL3XFFP81z3NwXHhHke9QcwztYWJlITkR7aXtHWtOnnVzD6lqz+V6R97OC/WVZyOOhmeL8e9raGAoPZ87urcjxDOcPuFrdUAzQVEM580Fz6rYnhV5ErQnA/yAKdCxItAr/GgNhg3wKIvypNufQzEwxIVbd8dFxhmCVOy7oJwxDWtUJs7kIwtNt3oKaIk7+p5dJAwt0Ml46Z5wjTKCl9blcjyfJ3be8da4HTeCEeHkpZcmqz3zy4Gn9m11DMbPkiP5nJ0pS2SAjoe0CafDUXwzjeXhBIl39urMsa7v1BAKhBS1cSdmUrgMaBxe6gFTXz1CgnZ2lhCFPpXBS2H/sXvAGYH8WBHfI8t5byOh7jt2sQI1nPntH7XmBT0cl1nwLAKeDniOhiZftOOHTHnC9GkvJ0ueJYzhz7teGQ1oG0nIKZ2cTdCmaCj5hYTc1YWKL96l3CmZJQPe/y7KTomg29+fzOl/5hGCDROWbR9O61ENNQh57tXKF5lu6KKOUltDGJRhfoGnltG7QWYQCvxC9sLBrshFnGhORBmXRy8EWiJ5gG4kjwbXFGHphew1bLZzN+TruO+/UoD69N3dcNGYSpB92gSduwt+JXx6X1tkBXRvtcByTGf49eakkxe5oLJb4zNtvLfAg+bn1yCoB8evY6mD2teCMef3GRhvbj6Emr0NNXjRStX8FmnZjRjPxRlF6hcRnvDKwqN3bXK3p6wm/hbrYX3PRDF7QtCDHN/b+Jo0mTXs/AGRfX5mIIkTNEOISR7GoDnDsywUCeawyclXtGmNU489lLS7vsIRtBny09t95cDAEn05zzXsDruX3g4ZiJ9V3T3+mjmAXOFTbA9tInEO92ttm7MwZeXbyms9+2aouKimS6icQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522f1918-b2ee-42bf-0326-08db40db3b37
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5867.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:37:34.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cz8i5tc73rr0D/MUrvzPl8e8nDkQxUwapKCfKhX5WuJiw+TE1zOLe+S1Bw0QQ5YgTqC6DDPuPy4RB8feYi/tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_08,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304190122
X-Proofpoint-GUID: QdgmtpvnS264LVdqEwPhnHd7TmpjEouq
X-Proofpoint-ORIG-GUID: QdgmtpvnS264LVdqEwPhnHd7TmpjEouq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 07:06:58 AM +0300, Amir Goldstein wrote:
> On Wed, Apr 19, 2023 at 5:11=E2=80=AFAM Darrick J. Wong <djwong@kernel.or=
g> wrote:
>>
>> On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
>> > On Tue, Apr 18, 2023 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
>> > >
>> > > On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
>> > > > On Tue, Feb 28, 2023 at 10:49=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
>> > ...
>> > > > Darrick,
>> > > >
>> > > > Quick question.
>> > > > You indicated that you would like to discuss the topics:
>> > > > Atomic file contents exchange
>> > > > Atomic directio writes
>> > >
>> > > This one ^^^^^^^^ topic should still get its own session, ideally wi=
th
>> > > Martin Petersen and John Garry running it.  A few cloud vendors'
>> > > software defined storage stacks can support multi-lba atomic writes,=
 and
>> > > some database software could take advantage of that to reduce nested=
 WAL
>> > > overhead.
>> > >
>> >
>> > CC Martin.
>> > If you want to lead this session, please schedule it.
>> >
>> > > > Are those intended to be in a separate session from online fsck?
>> > > > Both in the same session?
>> > > >
>> > > > I know you posted patches for FIEXCHANGE_RANGE [1],
>> > > > but they were hiding inside a huge DELUGE and people
>> > > > were on New Years holidays, so nobody commented.
>> > >
>> > > After 3 years of sparse review comments, I decided to withdraw
>> > > FIEXCHANGE_RANGE from general consideration after realizing that ver=
y
>> > > few filesystems actually have the infrastructure to support atomic f=
ile
>> > > contents exchange, hence there's little to be gained from undertakin=
g
>> > > fsdevel bikeshedding.
>> > >
>> > > > Perhaps you should consider posting an uptodate
>> > > > topic suggestion to let people have an opportunity to
>> > > > start a discussion before LSFMM.
>> > >
>> > > TBH, most of my fs complaints these days are managerial problems (Ar=
e we
>> > > spending too much time on LTS?  How on earth do we prioritize projec=
ts
>> > > with all these drive by bots??  Why can't we support large engineeri=
ng
>> > > efforts better???) than technical.
>> >
>> > I penciled one session for "FS stable backporting (and other LTS woes)=
".
>> > I made it a cross FS/IO session so we can have this session in the big=
 room
>> > and you are welcome to pull this discussion to any direction you want.
>>
>> Ok, thank you.  Hopefully we can get all the folks who do backports into
>> this one.  That might be a big ask for Chandan, depending on when you
>> schedule it.
>>
>> (Unless it's schedule for 7pm :P)
>>
>
> Oh thanks for reminding me!
> I moved it to Wed 9am, so it is more convenient for Chandan.

This maps to 9:30 AM for me. Thanks for selecting a time which is convenien=
t
for me.

--=20
chandan
