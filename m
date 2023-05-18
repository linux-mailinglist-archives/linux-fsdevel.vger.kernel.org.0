Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF20708314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjERNpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjERNoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:44:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6DC1A5;
        Thu, 18 May 2023 06:44:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6IrKs012428;
        Thu, 18 May 2023 13:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=r2HkOXWrE2qjoNxXvyoUsJExqJFrc8saIYVaEFx96qI=;
 b=X8brEjByapic5QAjcN/0rqUaIaLGwndEQiC4C1+Hje3IWjdluWjiRnuqk4GX6hMvmzYj
 MAiOme+mxCXBWrOe560vjMxG60wA41V68DFr3tMEZkVQkqAh+pJ4ee2wPASM9iEQ5pF7
 3H+HxP9Npb07r68RFIKJWUM5CtadMXYg/nL24/SO2II64JrZceiqX3gYqTCed+NSDc5d
 YqV390/+nHIy04W5ARWzHjwt1rzcvSuUhw8zq2UOeVaUnlU9TkbBHthvpjqTaoC+twsR
 VuTxUGBq5h8oI9tg1ImgzNPKUVUwWPDFP5227Yg6warXOPBGWNvw9R0l4rOZoYH1LYvb Qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpjjut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:43:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ICASTQ039972;
        Thu, 18 May 2023 13:43:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106hung-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 13:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8jLxGLI0T6hdZwMMhVVB2St9GAVdZ73FGxKWcLz2WRxnYCEQcXk9qUMg9+XViSRL7Azte7B0bU+IH1NOIf0HGIc8WBpsjULpZRvUldzYUMNQlvx0OEfigw48tVxJmTe3+BqpzVlFqz/NgjM8F3W2U8ZM1fDotah1jXMISb7euQJkVlJJZNupVUfKWIwG0IzVMFAh42EU9U4GLamvl4pP/zTc+NZl7smrqNDSwj1F1sS7YUK7zjib8ezkT37qQ21GBjIzsZ0VHOFQhghkcrxBJe7Stv2Y4GnkTpmRVp7RlWs6cUKAfbdKh41jXRwHmJXWhW8QSzzSDRVsz4beREH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2HkOXWrE2qjoNxXvyoUsJExqJFrc8saIYVaEFx96qI=;
 b=YRg3LTdF2B8z1iLvYJ/ePiwk9uopmVfP7XvI00D5WrRtvAlCZM4lKPlxZ+a5Dv3W7uoMJrdYGGRz2sVBySImDPQuHnqG9ZhABluv70R0bxPLFipbClozpwvxUzDkxYaGQwIE2wq6Bqx77e7lHJURM4pJvlruoYCBsqOXXYnU2iEdTPJHjuha+tGIZ+XnNybHmuyRRmPszzTYZ9QgAIVJDnXxWlnvKOZSjHFwi7bq8RUD6usAHH0sPfVZLR61ZfkYnVVPauaQnxKkwfrREMUUx6oR7hSOIb2azxNJS6M8dYYpcbywEz1jvLqeMSBjS3LJAy8I3SwvvOIpsS1Hp9PAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2HkOXWrE2qjoNxXvyoUsJExqJFrc8saIYVaEFx96qI=;
 b=Q8wUMXNlmjhhELeqD/Xis/swVBor/FrjwGrh6osQ+1YLOlVp959wp4/s4aXpTuD1jIvGdzs5HJVNgv85SCM7sFcw3J2aRKiXWd9/6oMLfs4McKi3ivqmUvZpLOnF5a8Uwo+Sv3ZZOGR60c/kbbTiZCwRKt4VUTrMX6uAe19HE88=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB7390.namprd10.prod.outlook.com (2603:10b6:8:10e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 13:43:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 13:43:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the
 inode->i_ctime
Thread-Topic: [PATCH v4 4/9] nfsd: ensure we use ctime_peek to grab the
 inode->i_ctime
Thread-Index: AQHZiX6ZSOeQa2wP1EiaEbUmb0Gvra9gCmAA
Date:   Thu, 18 May 2023 13:43:20 +0000
Message-ID: <2B6A4DDD-0356-4765-9CED-B22A29767254@oracle.com>
References: <20230518114742.128950-1-jlayton@kernel.org>
 <20230518114742.128950-5-jlayton@kernel.org>
In-Reply-To: <20230518114742.128950-5-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DM4PR10MB7390:EE_
x-ms-office365-filtering-correlation-id: 82b386da-eb13-4435-a96b-08db57a5d7fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I0PxyB6k0jvoZjySd6PDrI09Ak9duOt+8LTgQrFTdr559CSZE2MvWFAr+kNHO+VKQ6ZrYeNeLtWZSG90a69kJVWQH6J0nMueDdWvb3a24Wa/X4BugyIj1atxthhYW+4QnTKXT0mFvG7YaXPFZ+A9Y/hiXJtFYT0fmkF6U/Lpa6hf5FXzg8ZZzgB8cxIAt2FGe3FSX87qR35DJ/OmrgjarQY+k6Y6EBEupMXk0a5Pucl/euLncJrMmsccLJkHxPuMEwEmJzEi1drYRdfzn/gclBJw3mEpInP7FUclEvFrPwbmVhsfjw8WE6abQJgJ71sd9d2pZodhvBKU2irTE+hlhUIp16QFSP/lO6Wtf+izNsuKlqx998NdaENg/lsyhSZ8gsvr5GvJ63tTqQN3UNUVEdmri3CflxO20EQS4wkn81HvP4YBlaaH09Hq6QKpk327nkeaSVhYN8IxRQB7qicKM/KL+HGJV9MDwQK4p2Mn+XE4aH3uAZVIl/JN4EE0jyB8xz2cZQWMU+rgXsUv4kf5IDo4HEir2JbX39Ay5L2hjW5zK5gdqpWEsKXaSjkhQpFrhrYnsyG8HZywcXWARZap+KhAwh/4HEAt0lcrTLDqIRZqv60pC0ZnWV9hLNUVGjf1HuS/kouDhSHb+OWuFrYiOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(53546011)(6506007)(6512007)(26005)(83380400001)(36756003)(2616005)(33656002)(38100700002)(122000001)(38070700005)(186003)(2906002)(54906003)(478600001)(76116006)(66476007)(8936002)(64756008)(316002)(66446008)(66556008)(4326008)(6916009)(8676002)(66946007)(86362001)(5660300002)(91956017)(66899021)(71200400001)(6486002)(7416002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qv+qmNzEyzaIrHzCORwZYMfOUF02BckpBsVcP1pF/A/PPl6u6GTqWX+BSkWo?=
 =?us-ascii?Q?TMkTfvP0+DJxlRQIHaIkm7HJKja8yDQwn3Lnu5G35eRNTpAt1AQl/P19whRr?=
 =?us-ascii?Q?/mkAG4/MNvcOS2vZ+Y17x7KnYrpoqt/lh8HEqJ+MLyqEHW3Utc3lADTdqn2e?=
 =?us-ascii?Q?AeYjeCZfJEr0DjeEMzowMKLFP5OosUiYk4m0IOpepF8uefK879nXTQz83IZZ?=
 =?us-ascii?Q?w+Dt8GUpk6eD6bMVy24ZBQq0J08l4Nz0ajftusazKofGGMXKXFvd+o+Ns4KT?=
 =?us-ascii?Q?HhHwjzfeD/CGwGNKSJlPrfMJttmcIZH7Bv05fvP/CLfcuV4yTYAOyvgVkRM1?=
 =?us-ascii?Q?wEyE5qY3lQEtmGrWrTSwLg4vgHfRv2ZPe4nAIABe7x2oDlKBM1t3pNbnlX5u?=
 =?us-ascii?Q?3FgkdQd7G7HddCPcnK+BTJM0t4qJQBQb7PtrXiJdDpSViFa+LYbx2KVTLiyq?=
 =?us-ascii?Q?27kSSiwrmiXWFZWDq5ZxSg0nLHczvXRojKZHWaTIKytvS4snx07enKuuRchL?=
 =?us-ascii?Q?Xeb5uQCkiiEe6jl6QRD/PuCmn2gtVYtv7bc+KManyZQCdR0ZbkqRhblbMjhX?=
 =?us-ascii?Q?Kp/3fW8hxAIiysY8FzBfHpHe7NRNrU9erFam3GYhArDdU43joI3HcteP3SRV?=
 =?us-ascii?Q?Y4wcS2rtCvAvUaFMcmJd30H6ZiOtoV+CuLHxKiiGxge4PcbLMUkcXsGAM3He?=
 =?us-ascii?Q?mGjQ4pFfX/nV2p8A+uE+CvwH6c9j2QqJsUPA6bZiEvqisfLCx+Xh3XucyYPL?=
 =?us-ascii?Q?IE6uszVQgZDdjdNL2E5Tc4QtWxIWeOGlw3AesShbks1Udch5ATD2nsk3cGFK?=
 =?us-ascii?Q?p8QdjZ6t0W7w8GrJLn7XpvSm+bduuC8kAv+7de6FVvxM8/xU2SMI3XSdzx3T?=
 =?us-ascii?Q?UR4CRvkhTrhgF+ooUq/ualBb41Et9a+yOgnDCaMn37KfzQKwfUhlLPt2nkZI?=
 =?us-ascii?Q?OqdHqvPV+pUzXG1nw3T9Wt4TnHrLrksuDNdn0lk+NDt8R2GkcCxgsajAOn+h?=
 =?us-ascii?Q?bBWkcwqXs6o461OX7Ob2tFNY1GqO0wX63dfruPvl/Bc3DlNV/+D4ooGUqPub?=
 =?us-ascii?Q?1g2VhuaD35qS3lXZ4x5MkEBFb+hytHvbvnmUKleq9m0EP2gf/Zoyi3r0vuTL?=
 =?us-ascii?Q?Gj8EwNUh77SFSnYY9hBhak4NE61jclqxr9SUvlQ5sr0GgO1u8Cb0xjXkuOE4?=
 =?us-ascii?Q?z8dcgACLcvvb9q9KaG0AiLF1bDHOCMQDv/M7ZTITiN3J7+zKyShTttAD2o4x?=
 =?us-ascii?Q?iTwZE6gXL0CVR7vLsMH7V7Xj2N1Zikh7S+YBXlVA07ZGCfXUiMBGKhq2PuaW?=
 =?us-ascii?Q?Sfkro0kfG+rPCw3jwawXUpKH0ilxPKlr1BKFigfYj9oZiTsqaMtSvaLRK0y1?=
 =?us-ascii?Q?BjsPY6fJjb20SBtm77KY/tMw0spuZuX7e2USE9s6nvoFtOcT4SwhcfVxDaEI?=
 =?us-ascii?Q?4V3u/a1or9mNOQb/LzoKrcTBBTcS1EKak7GzAwx/xSeiba/nDpsB8ylB1y1S?=
 =?us-ascii?Q?+x1zmW2e01tDOoPbT/MdHSUTl8VG7d93jjjiO5Q4ufso/AsD4I/9kKugckzF?=
 =?us-ascii?Q?dbdw3PrGt6jsE1l7Hbuarq2ggkk9MhqJxVYl4YjdaeuhhjRPI8Wy6AuRZujN?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD8D5A3F2E8C264CAAC69F25DFE97C20@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZiZiwH6zRTRbWObSKdprEyz16vuIJFCKHZQvpe/vec7eQJMmOBfLkBQAuQiH?=
 =?us-ascii?Q?EAAlNjJaZI/f21yLPzzqSvNgR54Lywf9pegMgOt1irWorf+PP6vKTyVafNbv?=
 =?us-ascii?Q?Uz9Y24Zj5eMU4YBeoH9kfI/2ZMJmPR3rcwMSOqnyfBz37a9DlYUP5995v/Dg?=
 =?us-ascii?Q?A8Vkw0cVpanv6xp8JXoeLJ/Y3+C7B1i6PSJwPLXKEFbA2BbomGfMfN6uTq5W?=
 =?us-ascii?Q?TZiyqv8s8zRoI2vFuFI3nlrvd5ifHdGoNoVpIbqQTckQmi5MN248wUHSogq/?=
 =?us-ascii?Q?o3Ouk17953wqTwZv5UZmIa21ycWGHG4scSsw4J8h17BEqM+d1xR6k6AwGs3Z?=
 =?us-ascii?Q?8Tby1Nc7KeWMp28oDRRQTcyrfalDRPSaVkGe3W8OnhW8am6cdjFfzZF1SBqk?=
 =?us-ascii?Q?NEce/9Md3Ac4gGjbCiERqpx9x23D1sWc7hPI4u2HOi6ZBFJ05KMVT2BX3Rw7?=
 =?us-ascii?Q?+T8Q/4FYCq7+IYh6kqq8PKaa1KHAijZlx/k8jAluq+MQwmlbXe1w9AALdWGJ?=
 =?us-ascii?Q?GUQo/IZVERYLNCNr9yQnUsELQ64upgMlHqE8U08z+JEsm0CJMzPGnlMMVQlR?=
 =?us-ascii?Q?DkxOcttM9VECNQnn54I9F8oru9VvQlQUCje6YjFIvLoi4B3ZL6ct48lmyOKI?=
 =?us-ascii?Q?Z8zzM6b0sLf8z7Z+JhIhjUwo5TGfJfltO7R7g43JPUHy8OMJcwVsiB3nUWUz?=
 =?us-ascii?Q?+6ejY+AJ3oMEC3o3sHedvuI4q2sFRu0so1TOlk4Fh7Y9PYTMo0hR9vxKWIUw?=
 =?us-ascii?Q?R56M11346iCCNCGRr2ZtNO4KGj/lkx9ZEU6S9bkkTR/GhEl5N5u/xbHKveBj?=
 =?us-ascii?Q?m2AK3a4u52pHoo81weqXlOK7B8Jm+sX6g/6bPmsoj7jlJFCEk3wcdAmPoLKj?=
 =?us-ascii?Q?lx/cPTJt977nXhXYzpjuTVbKnXX5lVtpA889PPZ3172eKmbYxm1+g1Ud78s5?=
 =?us-ascii?Q?ULy87dEcZWvzlcMpDj1XZSEHas/A5DFCUrNxWRZ1TeAIkqpODrI6toPJti5N?=
 =?us-ascii?Q?fxiUjLV8OQ1oFvXlDeIU4XivBUFhtTKPwRPDbMMqSXyfZc1FZCwJnkgLxZR7?=
 =?us-ascii?Q?i9g371DPUfVlxoPznBqUMzcx6kHTsFEKO27NwLp8Jxwk0RkvH/FPXpp0n2+B?=
 =?us-ascii?Q?5uY5/KJGwKNiF0HHmGcl7Kp6Dikh40QK8XMUeNZ2GaLcbCzcWrUAJwbqcvt1?=
 =?us-ascii?Q?dEAxGtS1QibB6ncFRj8eyyICWdXqw8NQxoT1N+ICymaHFVats684Wd88nY7W?=
 =?us-ascii?Q?5CEFtdpf7cwO8OP5rjHfMFb4HUVrNVA4cAj237jRBtmWTWFWtaG5kL6TC3E7?=
 =?us-ascii?Q?Rs43L8mGnefgh1qzYjvL9jdzAOFlw7HfpaECWayCOM47Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b386da-eb13-4435-a96b-08db57a5d7fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 13:43:20.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4omuT9yAOkn+jrHLfhxeVYmGfkfoA0klNx8g3a6v1edVdupi1RTtC7Kz8tdCr8DUR9J3IcjrGVKMOgkFbZxXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180109
X-Proofpoint-GUID: ZGUqQXYnY_gzdK6WM8Dm5DXPx-ArkFcS
X-Proofpoint-ORIG-GUID: ZGUqQXYnY_gzdK6WM8Dm5DXPx-ArkFcS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 18, 2023, at 7:47 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> If getattr fails, then nfsd can end up scraping the time values directly
> out of the inode for pre and post-op attrs. This may or may not be the
> right thing to do, but for now make it at least use ctime_peek in this
> situation to ensure that the QUERIED flag is masked.

That code comes from:

commit 39ca1bf624b6b82cc895b0217889eaaf572a7913
Author:     Amir Goldstein <amir73il@gmail.com>
AuthorDate: Wed Jan 3 17:14:35 2018 +0200
Commit:     J. Bruce Fields <bfields@redhat.com>
CommitDate: Thu Feb 8 13:40:17 2018 -0500

    nfsd: store stat times in fill_pre_wcc() instead of inode times

    The time values in stat and inode may differ for overlayfs and stat tim=
e
    values are the correct ones to use. This is also consistent with the fa=
ct
    that fill_post_wcc() also stores stat time values.

    This means introducing a stat call that could fail, where previously we
    were just copying values out of the inode.  To be conservative about
    changing behavior, we fall back to copying values out of the inode in
    the error case.  It might be better just to clear fh_pre_saved (though
    note the BUG_ON in set_change_info).

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

I was thinking it might have been added to handle odd corner
cases around re-exporting NFS mounts, but that does not seem
to be the case.

The fh_getattr() can fail for legitimate reasons -- like the
file is in the middle of being deleted or renamed over -- I
would think. This code should really deal with that by not
adding pre-op attrs, since they are optional.


> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/nfsd/nfsfh.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index ccd8485fee04..f053cf20dd8a 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -624,9 +624,14 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
> inode =3D d_inode(fhp->fh_dentry);
> err =3D fh_getattr(fhp, &stat);
> if (err) {
> - /* Grab the times from inode anyway */
> + /*
> + * Grab the times from inode anyway.
> + *
> + * FIXME: is this the right thing to do? Or should we just
> + *  not send pre and post-op attrs in this case?
> + */
> stat.mtime =3D inode->i_mtime;
> - stat.ctime =3D inode->i_ctime;
> + stat.ctime =3D ctime_peek(inode);
> stat.size  =3D inode->i_size;
> if (v4 && IS_I_VERSION(inode)) {
> stat.change_cookie =3D inode_query_iversion(inode);
> @@ -662,7 +667,7 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
> err =3D fh_getattr(fhp, &fhp->fh_post_attr);
> if (err) {
> fhp->fh_post_saved =3D false;
> - fhp->fh_post_attr.ctime =3D inode->i_ctime;
> + fhp->fh_post_attr.ctime =3D ctime_peek(inode);
> if (v4 && IS_I_VERSION(inode)) {
> fhp->fh_post_attr.change_cookie =3D inode_query_iversion(inode);
> fhp->fh_post_attr.result_mask |=3D STATX_CHANGE_COOKIE;
> --=20
> 2.40.1
>=20

--
Chuck Lever


