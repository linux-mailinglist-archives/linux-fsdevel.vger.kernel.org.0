Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBE6326FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiKUOxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 09:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiKUOxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:53:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68AF942E2;
        Mon, 21 Nov 2022 06:44:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALESjYR005048;
        Mon, 21 Nov 2022 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oMpqK3Pb0QZXn0B5cUvUng5V4mdqvUtt/ZmyXIjiWl8=;
 b=eTMAaRizkcenldqwyuWv5AQU+SMjLycZi5HYUIDDM/Qnlv5dJecGM50uA2kGF1yrYSZ5
 j1P+V6ycP5jqano8UhHbhmF9CHUQFyAlHapG3q76jvxOKk9gxcck1iV+JV/XVQvqL/1z
 Blv1lo2j9mXrCz2NS1eR5PI+cZHVyabGPCsmbxOHx65fTFLjNyXKeMz1PGYdlW11y2qW
 2hvY6eKqaXJ+6mYhzpiI56wvz3G9g5GiGIJIT/U5bb55h5zMKnbs8FH0OvDubXLvyWla
 3wkvDfIoROXvR0fxy7NBdSZ22iZsA5HYozG6ge3lqXcpXV/c/Wg/yAqO05nNLZhFZk8h xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrd7vd2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 14:40:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALDnAGi008340;
        Mon, 21 Nov 2022 14:40:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk39qwh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 14:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HewaOYmXDglYp0l6O0b7RAu/rXYAnoQJ49t0tw9+LkoLUNj374DX4HFjtba311l14Yh1BDMYhl6voLNy1uay9JDKntiTu7hihY/5BZR8a11KnPyV1pXUYRxmwVVhk44SByVCLjFk8EuzYe6aYSbWSaVfmv3OBlzQ9+IlP/C96xJBORlmUu1ZrELnqpzuXfAr1pNdU2IafCexoEKyUsi6Y/Y+oCPYwzfMIJMfedzHmN2t+7evjQSBozTfXCZ5jyAeFNwYia9SSkyyBITEykhZNrPHe5yv2YANlb0UzT4LX1o2a4Et4IbbdpK8NBkwJVhr9tsPXV7u5yzeufuEAf+myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMpqK3Pb0QZXn0B5cUvUng5V4mdqvUtt/ZmyXIjiWl8=;
 b=RdR36gRkjxY1LjU3ODnUZN5stdDt2mxHuOHz8zXTWlJDki8hZxVHCVlea8P5DJ2c2X77pc0LqoA/MsCqA5b0FwQl9eITDeFvCVV2PP9SHqdfiy62XDGRKJE5VJs5OzZ4fKM5dw/+mdj3UhKUzZb98My9IQddj7OCtK0zMQRR6DVTB2THPC9krJg4KJYT2tJLnT9xQCC7PmoM/mGhjuZJ1Akh/5rQVPZizb4ZbuT61Y+08ooqni14a+jbeo0qyo7CR7Bj9T1wly436TciA4UmXSw6LLvdaJaMHAYWIJXA7Jtxv9B5K108moGztX4mLZSfUhnHoyYxlqNM8l+9WQRpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMpqK3Pb0QZXn0B5cUvUng5V4mdqvUtt/ZmyXIjiWl8=;
 b=KKzYAFexRnaVaO/1lqQp6cCzEbdfANemujaQrNKeg7j7l6NOfxdJPZZKBJRuQSpIdlRMFLCxxpB/F844C1URo/azrGZIX8hv+QvhXgy7ZPuPPZFvRJ5a+Wr17LJdr1iA3VLs0EzlZU1uFcCSDqSreNrIKTX5HmocS5h/HZ0bxv0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 21 Nov
 2022 14:40:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%4]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 14:40:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        "Darrick J. Wong" <djwong@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] filelock: move file locking definitions to separate
 header file
Thread-Topic: [PATCH] filelock: move file locking definitions to separate
 header file
Thread-Index: AQHY/SMXq4bKiU+EGEezkZATbxQWl65JdDAA
Date:   Mon, 21 Nov 2022 14:40:43 +0000
Message-ID: <067DA10A-6548-4F53-BF21-A88363340A3A@oracle.com>
References: <20221120210004.381842-1-jlayton@kernel.org>
In-Reply-To: <20221120210004.381842-1-jlayton@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN0PR10MB5959:EE_
x-ms-office365-filtering-correlation-id: fc61d4aa-5638-4af3-99a8-08dacbce5e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DP84tb7m+3/6r9vKdnU4x4y31uLDa9AvIZVxptTk80g2KZGh2AM8wTeQ+OElzMoknclbYxiOF3o5Tjeu1EoEoeyrBpANNXYRNOVmk1YxQr8BlZehoRs446pxkspgOuP+NNy9Hpee8vTGiv8e8fkeKe5HzyU3e2I698FLicQ3kGjPzACNiY+N2xpLlbprfTPlY1VPiNmvGe13k2dM2+N1y8/hKBRxEsN2MhlIl5Ou8r3X4dRgS6+k76QaGm4O5zupd6GzgB8VJ7aKHQdh8u1NTJwqaZtCS50k6H+8mgONCkx5cgpBQ+hWw3sH8Keu5pL210OYfDNwa+iyAjhrXCJMG3GAU4+bRgdSTtvW6NWgNFv11OYdgi45gPlAg7VEY0W3JN+mfZZMPoXxnRulFmIRXSnvxy558vh+vtwmiQRxQ81SscX5PbtG06oMpj7x96+/rwXYkms1gn7knCpIcI7B2bZFZUis/yL1PgStp0tZpKpLhULdkHKu4AXl4vpWeZnPpN0DHtQEBvWJzw3ts7q4zCIEQgIgxrILouQe+j3NN1btXDYy2P8gG6UjxH05IzF9Ux51raT9GBsMdxO6ox9mR6HdV0AZtWRXe/cBtTI1NuIukwra1qX9snp5UfnGKQqijqHATacnK1OcA+iBjVXLpXpSRJiyTCxb5wPyXoCRok8JtUXf0y2caJGXuNAMxKdtMhqREKiJG4IRR8LcFTXXPUvcb7oBplqG4yppj/tmKjA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(8676002)(66446008)(64756008)(36756003)(91956017)(2616005)(76116006)(8936002)(7406005)(26005)(66476007)(30864003)(41300700001)(66946007)(5660300002)(6512007)(66556008)(7416002)(186003)(4326008)(316002)(122000001)(86362001)(53546011)(83380400001)(2906002)(38100700002)(478600001)(33656002)(38070700005)(71200400001)(54906003)(6486002)(6916009)(6506007)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ZTAq9jyronuCFVthr00lMX2DBbhdfeTYFJKSEdAMfl0ZFdXtj+CWBHsh9Hu?=
 =?us-ascii?Q?ohFkKMEuf+qcmw5jYOdw4JZcRAM/RxX5hJIT+3io2Uf3voK9mh08Y9sC27oj?=
 =?us-ascii?Q?ZZBKckXt1DL13uSIOUbjvOcYfUKCBm5GM7LVEaBOUylS6fZb6mUffWYML0Xy?=
 =?us-ascii?Q?pvRePmE+KZTrbunZjR+1tSTAH7tw/wkP9lH2VeOFHp19Y6NPapd8/ZoLsH9w?=
 =?us-ascii?Q?c2y7ExBQ+MfA8GhLxDhusIAfbec2SglDIGuC7mCBzmvv8ruB2RpfpB7qeQzc?=
 =?us-ascii?Q?Yl5TmK4A3O48M+yrpkRh6FhIysNbVwA8DtX1MvB4zBUXbTwjTOYV4ue9f+M4?=
 =?us-ascii?Q?GD1DxmM1ajhE3qoGrp1z0a9Oh26m1o9crpeOQLXKFl+sMHj5mN/YaGpTSOai?=
 =?us-ascii?Q?groGM/PCW3y2uxaF2TBzTf7ogqoJR4qxzliQkBMeejp+ieHUCvd29+H/qYiU?=
 =?us-ascii?Q?IjIT1tBra/YOwQU1AA5Qu+6/nDf9iAhMPUkdyLM0s2bE2nhFsUnM7bPdXoxn?=
 =?us-ascii?Q?kDe7C2tbuIzRQWpS+6QjtmgmdpDvMa9r63rYeam7kCv9idWAhF/k8HWhY14H?=
 =?us-ascii?Q?rQhr8d45tI/dwG8WfwqIC2eHe8nr+VLzMz5WyzsezarQREM+q2CaWBH2sg/f?=
 =?us-ascii?Q?B+zuL30KpCFih0pB7KEzkbaBSgAUlJkhUw24/DeOm/Ey29q6sF/emnezQBck?=
 =?us-ascii?Q?Gy2kxydfSBk3hcX6LL+i5o5BsPfP1NLfwGbdwdKsnqRbI2PJZJt7HSG+HjSH?=
 =?us-ascii?Q?zUM6jachO0SrfJP0J7cP+GMoic3QGrkH9RukNXYv43gD62rczkcVc/rbPfbW?=
 =?us-ascii?Q?I/2XBEUeb70eQexRxckG4CnTUD9NCYfHmDaoniHsUfxdzrrd1wc+I5vSNsq3?=
 =?us-ascii?Q?lrUj97kmiOEiwLrKi42AWJ5octHRm8PgbuF1xwWJSTb/ya09ew2aoYrt3x9D?=
 =?us-ascii?Q?j0dIBzha5xEPyFGm7wRtsJ+H2n12g/lSCOyJTe+HD5psgCR1xNLG4hXjh4IH?=
 =?us-ascii?Q?9QBoirHxTBl2F76Xyz5p2IKTZ7T7jjBuve+pBz4T8+igV7AO7lE6yVN+0Ecf?=
 =?us-ascii?Q?DGtIFeHqj3+GRm9c6R41tmPQTNvClcY2Dv114Ll4D6Eg7UzZPf4JKGKnqxXO?=
 =?us-ascii?Q?cDBx8Ij+dGdFhwGxdAwSvLI5a5M4Y40NgPmUvtQA6fv8ssxFdtqVdFwlyNSD?=
 =?us-ascii?Q?MoEvGGwFwPCiIHdzz65rCFX8wRFPY6z0LPozODiIScZCxjNCibLsfDOX/DeH?=
 =?us-ascii?Q?rKlpveu4ExU0JDq4C1Pdv2mwa9sHS4N0iEJtyuMD5mukQL9NlXSyVD1fUavd?=
 =?us-ascii?Q?R2h+zawLZdIKHZdF6ndZLckc6X4XI/FPlCxxmHkJ8wX14hdR2Vz2QC9sjmje?=
 =?us-ascii?Q?KcAqx3whA5R5a5r+2wfg/F/Yfi/0wHmE7+XUg84Xpaycxi8W2NBa3mMuSZwP?=
 =?us-ascii?Q?AtFJxSVNyPoPSzGsIcDQYIi000oAj0PAKaNiPZhoV+xXKDg1sPriWhbr/SfJ?=
 =?us-ascii?Q?Fw/uDd44VSYG27TdO9qRKTzX0e3yyXQ6umyWiKrYhU65rZIkwlZQFkubk1Lc?=
 =?us-ascii?Q?eSX0LDJ6U3tJqYHcTNiB/H9gk9SzagR4PYhvYBndpygJzER+iyaeiRLnWJW9?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <478E83781FE6434C8446167AA74CA27A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JLsnHFEn25W/BUDNQ/2FH8L4Oce4/lqXXQ9xdvlQ0PUVQ2v9GBnDUMbAmoAR?=
 =?us-ascii?Q?JpvQJukkQ69OZU1yNVL4BUfg/J6b8zmGey02rgv7uw7GoUrYNSLSuTBbq5qn?=
 =?us-ascii?Q?QbI8Cow5+s+CZfgIywcQx4Fl4wfKVzvNa8N0lLbqr7Wm2+re8RCM8P/DtiJN?=
 =?us-ascii?Q?uBZFjbAb6wD/ubl4y6GKKB+lhBIp9QsOm8bHIkYb95Ilnw6TwADH/UDVve34?=
 =?us-ascii?Q?hcpX0zghmcGksI+uRnSVxCoxZgGQkW8C+c4ClTel6gA7qj6x3y+2uSHj0eHR?=
 =?us-ascii?Q?cJULctnMAo/s7U285qctbmG59ToyMTr8fmIgoaDglL6ia0eiy4KtOsDkAIrD?=
 =?us-ascii?Q?6SwFTzDj9R5v6aYhLRcdnTp2nxjgJPXD9Nux0bWo8yHQN1opOIFdhIIj4JG/?=
 =?us-ascii?Q?au1PY9u5qjpaDaFGWQjedIsJPQeMlvib8Im4rZ5YPmxa45VlHD2JeMbrfGgV?=
 =?us-ascii?Q?DAIMZlfLIeCah4Yb5Nbao8ZqbDOl9ZkRdyyjebkm+zmet7Aauz2fNjGPM9Zy?=
 =?us-ascii?Q?wxLzkOsb/3uCQ12KfUKlDYdjA8SYvKLuizkETflai4s+eOX046ZpzXSBz/9A?=
 =?us-ascii?Q?lLb2wLkfSzlX6hvvK6PX+LXpfHaeTW9S6BljHnhPRn/6Wr0yO0dv8HDUbjxg?=
 =?us-ascii?Q?0NJE7u5rArY87d7U2NCwyFJZ8a40uM/RJIGezycEfKqmAcWX/2Amk6Am14dD?=
 =?us-ascii?Q?Y2h5L0dx2931VA0K7z68RBxhWyoaSnoOFC3uVoiTguBbkjf7Lf2uMl2kdDdH?=
 =?us-ascii?Q?0HNX7pNopSZ9IqPga5RZNewM7TCYcRraQ1viuaSKxN29YICn/yWyjwyOViJR?=
 =?us-ascii?Q?wt9cCrrpukoX96a6qw0jKRK7LNqACLRcFFVUVFpqOdUHKJYlq4Q3j6OQDo6H?=
 =?us-ascii?Q?LMF/rFf8Pr7Q2Uj612yahGTX7zs5R7g1hbwoWQHlYV385XGMoGNluXH4UXDw?=
 =?us-ascii?Q?A8pksrtX0AqoV4ZoRVg9e1ZqbqJ8Kotnlq6Mjf9R68iCI5Iy6vuLMt82+mR1?=
 =?us-ascii?Q?/wRixn4TwqKCyIWYqcHNEETXya57GUKre8avvs8/vwT2i7z1ub5sr8BLJIS0?=
 =?us-ascii?Q?0h+2xe29JqQgZHr9hdUNxP9nkB/CNjKJL2uSF1qymUwTmXHppwExNlDSEVAl?=
 =?us-ascii?Q?4Zpo1KIhUHWVjHg0MJW8hoJ/peF9NiZ2muPHlIAmhToKn6b/Ws8WZG+4Me0S?=
 =?us-ascii?Q?vemp77bE2Vj+e91vnQ0WqnfNxLt5EiushuVT9/CrDR+3ghty+KWhMSabKBmS?=
 =?us-ascii?Q?Q7ZUX3+Wzh8OdQ0EwGC8s80ctDnvLcsi+rhSs8mKq4bdv/8Drl63D7NON8sF?=
 =?us-ascii?Q?K1C35jLID6tl4pmcxOi66vFtBd1WNH8EZgOQLh5iRjLFR99/xBMoak5HVGzf?=
 =?us-ascii?Q?jtYnI0lgHWv35S+YkALCRdiBAAKT7tIR+1r5OfXKtskIQ2bQ/aa2y6SivpdG?=
 =?us-ascii?Q?YZUrjRrN9AtlcZDVwGBppH0qKYfBctOZAF8GQhKeQQBvTJ2tCXWWosCgpcWW?=
 =?us-ascii?Q?qJtNU+Ii86KJjAwgZ/6xKogUKn+JD/gw0Jgys+QBCVcCjUrOJcRDaqjqKAUE?=
 =?us-ascii?Q?tlc/a+35UEyAYbZIS5FPFF9T/1Pk7yDGzBzZ7o0GoeHS2gj3zKaNNWDIHLvP?=
 =?us-ascii?Q?MfhRrrHgv0SohbOOquFV/RgpNj52o9JKidTAak9buYabG0nYrlaNycP7dz1R?=
 =?us-ascii?Q?CCXmjPkQ/w8b7Oso3CPWUb3QAkSaSAUsSOLDhJUA/qFf1NRuiMtuEjMx1qPb?=
 =?us-ascii?Q?7M0noe15m+H6y/pA6xJHFn5DeLms7eU9gL4/uSugtDM5wZb3SZ0tHEGF5r9N?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: tx5LeaAyAZCx1TOJ3xeYQ5et46us7tRb9TjfzzSaqlohPcdut9OdDsGU7vmI9hsEYH4/GCsKFAGw189aDz0yerZjlS8T3CEgo7FEK/7K0oBojx+iDtW7Dp1nhvYwU/DM9MKN93HXwp80AGr85FFXTexy6Cc56g41F5kqPd6pr9I3EW24/7JvkhCEQDJSFKScyjjLzX2w/Ptqtsiskby3YpxXwmkfNbvcJOWVxhuHPMatfUvb/ccG5LClRGjFz7OY1omfTDGZedUTO8wTjh8KgQKZBjWVwiAUKSpAkrl9/+u8rwwVnP8koRIGCrzcvT54lHB8R+VGuDaK4/LUqK2QCZyP2ZB5CFMbmuVuQ4rSWTFVxFT9sHcP719cMkSzMW7eyaS6cFZkYcVTfyV6EsE7JNMAXomQgbQ0T3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc61d4aa-5638-4af3-99a8-08dacbce5e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 14:40:43.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHvlRpTFd6OP3DR1rjv960rwCaGAnP84H2blvNPWXqL8NyI6xnsMiXA6TZsNjRqCCDCOZCIZLNjfyOpVi36ZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210113
X-Proofpoint-GUID: dfLYcvwXRmmTUZRa8VdnPpMWYNyG0ALe
X-Proofpoint-ORIG-GUID: dfLYcvwXRmmTUZRa8VdnPpMWYNyG0ALe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Nov 20, 2022, at 3:59 PM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> The file locking definitions have lived in fs.h since the dawn of time,
> but they are only used by a small subset of the source files that
> include it.
>=20
> Move the file locking definitions to a new header file, and add the
> appropriate #include directives to the source files that need them. By
> doing this we trim down fs.h a bit and limit the amount of rebuilding
> that has to be done when we make changes to the file locking APIs.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> fs/9p/vfs_file.c          |   1 +
> fs/afs/internal.h         |   1 +
> fs/attr.c                 |   1 +
> fs/ceph/locks.c           |   1 +
> fs/cifs/cifsfs.c          |   1 +
> fs/cifs/cifsglob.h        |   1 +
> fs/cifs/cifssmb.c         |   1 +
> fs/cifs/file.c            |   1 +
> fs/cifs/smb2file.c        |   1 +
> fs/dlm/plock.c            |   1 +
> fs/fcntl.c                |   1 +
> fs/file_table.c           |   1 +
> fs/fuse/file.c            |   1 +
> fs/gfs2/file.c            |   1 +
> fs/inode.c                |   1 +
> fs/ksmbd/smb2pdu.c        |   1 +
> fs/ksmbd/vfs.c            |   1 +
> fs/ksmbd/vfs_cache.c      |   1 +
> fs/lockd/clntproc.c       |   1 +
> fs/lockd/netns.h          |   1 +
> fs/locks.c                |   1 +
> fs/namei.c                |   1 +
> fs/nfs/nfs4_fs.h          |   1 +
> fs/nfs_common/grace.c     |   1 +
> fs/nfsd/netns.h           |   1 +
> fs/ocfs2/locks.c          |   1 +
> fs/ocfs2/stack_user.c     |   1 +
> fs/open.c                 |   1 +
> fs/orangefs/file.c        |   1 +
> fs/proc/fd.c              |   1 +
> fs/utimes.c               |   1 +
> fs/xattr.c                |   1 +
> fs/xfs/xfs_buf.h          |   1 +
> fs/xfs/xfs_file.c         |   1 +
> fs/xfs/xfs_inode.c        |   1 +
> include/linux/filelock.h  | 428 ++++++++++++++++++++++++++++++++++++++
> include/linux/fs.h        | 421 -------------------------------------
> include/linux/lockd/xdr.h |   1 +
> 38 files changed, 464 insertions(+), 421 deletions(-)
> create mode 100644 include/linux/filelock.h
>=20
> Unless anyone has objections, I'll plan to merge this in via the file
> locking tree for v6.3. I'd appreciate Acked-bys or Reviewed-bys from
> maintainers, however.
>=20
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index aec43ba83799..5e3c4b5198a6 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -9,6 +9,7 @@
> #include <linux/module.h>
> #include <linux/errno.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/sched.h>
> #include <linux/file.h>
> #include <linux/stat.h>
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index 723d162078a3..c41a82a08f8b 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -9,6 +9,7 @@
> #include <linux/kernel.h>
> #include <linux/ktime.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/pagemap.h>
> #include <linux/rxrpc.h>
> #include <linux/key.h>
> diff --git a/fs/attr.c b/fs/attr.c
> index 1552a5f23d6b..e643f17a5465 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -14,6 +14,7 @@
> #include <linux/capability.h>
> #include <linux/fsnotify.h>
> #include <linux/fcntl.h>
> +#include <linux/filelock.h>
> #include <linux/security.h>
> #include <linux/evm.h>
> #include <linux/ima.h>
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index f3b461c708a8..476f25bba263 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -7,6 +7,7 @@
>=20
> #include "super.h"
> #include "mds_client.h"
> +#include <linux/filelock.h>
> #include <linux/ceph/pagelist.h>
>=20
> static u64 lock_secret;
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index fe220686bba4..8d255916b6bf 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -12,6 +12,7 @@
>=20
> #include <linux/module.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/mount.h>
> #include <linux/slab.h>
> #include <linux/init.h>
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 1420acf987f0..1b9fee67a25e 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -25,6 +25,7 @@
> #include <uapi/linux/cifs/cifs_mount.h>
> #include "../smbfs_common/smb2pdu.h"
> #include "smb2pdu.h"
> +#include <linux/filelock.h>
>=20
> #define SMB_PATH_MAX 260
> #define CIFS_PORT 445
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 1724066c1536..0410658c00bd 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -15,6 +15,7 @@
>  /* want to reuse a stale file handle and only the caller knows the file =
info */
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/kernel.h>
> #include <linux/vfs.h>
> #include <linux/slab.h>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 6c1431979495..c230e86f1e09 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -9,6 +9,7 @@
>  *
>  */
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/backing-dev.h>
> #include <linux/stat.h>
> #include <linux/fcntl.h>
> diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
> index ffbd9a99fc12..1f421bfbe797 100644
> --- a/fs/cifs/smb2file.c
> +++ b/fs/cifs/smb2file.c
> @@ -7,6 +7,7 @@
>  *
>  */
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/stat.h>
> #include <linux/slab.h>
> #include <linux/pagemap.h>
> diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
> index 737f185aad8d..ed4357e62f35 100644
> --- a/fs/dlm/plock.c
> +++ b/fs/dlm/plock.c
> @@ -4,6 +4,7 @@
>  */
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/miscdevice.h>
> #include <linux/poll.h>
> #include <linux/dlm.h>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 146c9ab0cd4b..7852e946fdf4 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -10,6 +10,7 @@
> #include <linux/mm.h>
> #include <linux/sched/task.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/file.h>
> #include <linux/fdtable.h>
> #include <linux/capability.h>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index dd88701e54a9..372653b92617 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -13,6 +13,7 @@
> #include <linux/init.h>
> #include <linux/module.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/security.h>
> #include <linux/cred.h>
> #include <linux/eventpoll.h>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 71bfb663aac5..0e6b3b8e2f27 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -18,6 +18,7 @@
> #include <linux/falloc.h>
> #include <linux/uio.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
>=20
> static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
> 			  unsigned int open_flags, int opcode,
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 60c6fb91fb58..2a48c8df6d56 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -15,6 +15,7 @@
> #include <linux/mm.h>
> #include <linux/mount.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/gfs2_ondisk.h>
> #include <linux/falloc.h>
> #include <linux/swap.h>
> diff --git a/fs/inode.c b/fs/inode.c
> index b608528efd3a..f32aa2ec148d 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -5,6 +5,7 @@
>  */
> #include <linux/export.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/mm.h>
> #include <linux/backing-dev.h>
> #include <linux/hash.h>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index f2bcd2a5fb7f..d4d6f24790d6 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -12,6 +12,7 @@
> #include <linux/ethtool.h>
> #include <linux/falloc.h>
> #include <linux/mount.h>
> +#include <linux/filelock.h>
>=20
> #include "glob.h"
> #include "smbfsctl.h"
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index f9e85d6a160e..f73c4e119ffd 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -6,6 +6,7 @@
>=20
> #include <linux/kernel.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/uaccess.h>
> #include <linux/backing-dev.h>
> #include <linux/writeback.h>
> diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
> index da9163b00350..552c3882a8f4 100644
> --- a/fs/ksmbd/vfs_cache.c
> +++ b/fs/ksmbd/vfs_cache.c
> @@ -5,6 +5,7 @@
>  */
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
>=20
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index 99fffc9cb958..e875a3571c41 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -12,6 +12,7 @@
> #include <linux/types.h>
> #include <linux/errno.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/nfs_fs.h>
> #include <linux/utsname.h>
> #include <linux/freezer.h>
> diff --git a/fs/lockd/netns.h b/fs/lockd/netns.h
> index 5bec78c8e431..17432c445fe6 100644
> --- a/fs/lockd/netns.h
> +++ b/fs/lockd/netns.h
> @@ -3,6 +3,7 @@
> #define __LOCKD_NETNS_H__
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <net/netns/generic.h>
>=20
> struct lockd_net {
> diff --git a/fs/locks.c b/fs/locks.c
> index 8f01bee17715..a5cc90c958c9 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -52,6 +52,7 @@
> #include <linux/capability.h>
> #include <linux/file.h>
> #include <linux/fdtable.h>
> +#include <linux/filelock.h>
> #include <linux/fs.h>
> #include <linux/init.h>
> #include <linux/security.h>
> diff --git a/fs/namei.c b/fs/namei.c
> index 578c2110df02..d5121f51f900 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -20,6 +20,7 @@
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/namei.h>
> #include <linux/pagemap.h>
> #include <linux/sched/mm.h>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index cfef738d765e..9822ad1aabef 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -23,6 +23,7 @@
> #define NFS4_MAX_LOOP_ON_RECOVER (10)
>=20
> #include <linux/seqlock.h>
> +#include <linux/filelock.h>
>=20
> struct idmap;
>=20
> diff --git a/fs/nfs_common/grace.c b/fs/nfs_common/grace.c
> index 0a9b72685f98..1479583fbb62 100644
> --- a/fs/nfs_common/grace.c
> +++ b/fs/nfs_common/grace.c
> @@ -9,6 +9,7 @@
> #include <net/net_namespace.h>
> #include <net/netns/generic.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
>=20
> static unsigned int grace_net_id;
> static DEFINE_SPINLOCK(grace_lock);
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..bc139401927d 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -10,6 +10,7 @@
>=20
> #include <net/net_namespace.h>
> #include <net/netns/generic.h>
> +#include <linux/filelock.h>
> #include <linux/percpu_counter.h>
> #include <linux/siphash.h>
>=20

For the NFSD piece: Acked-by: Chuck Lever <chuck.lever@oracle.com>

Although, you are listed as a co-maintainer of NFSD, so I guess
this is completely optional.


> diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
> index 73a3854b2afb..f37174e79fad 100644
> --- a/fs/ocfs2/locks.c
> +++ b/fs/ocfs2/locks.c
> @@ -8,6 +8,7 @@
>  */
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/fcntl.h>
>=20
> #include <cluster/masklog.h>
> diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
> index 64e6ddcfe329..05d4414d0c33 100644
> --- a/fs/ocfs2/stack_user.c
> +++ b/fs/ocfs2/stack_user.c
> @@ -9,6 +9,7 @@
>=20
> #include <linux/module.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/miscdevice.h>
> #include <linux/mutex.h>
> #include <linux/slab.h>
> diff --git a/fs/open.c b/fs/open.c
> index a81319b6177f..11a3202ea60c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -33,6 +33,7 @@
> #include <linux/dnotify.h>
> #include <linux/compat.h>
> #include <linux/mnt_idmapping.h>
> +#include <linux/filelock.h>
>=20
> #include "internal.h"
>=20
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index 732661aa2680..12ec31a9113b 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -14,6 +14,7 @@
> #include "orangefs-kernel.h"
> #include "orangefs-bufmap.h"
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/pagemap.h>
>=20
> static int flush_racache(struct inode *inode)
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 913bef0d2a36..2a1e7725dbcb 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -11,6 +11,7 @@
> #include <linux/file.h>
> #include <linux/seq_file.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
>=20
> #include <linux/proc_fs.h>
>=20
> diff --git a/fs/utimes.c b/fs/utimes.c
> index 39f356017635..00499e4ba955 100644
> --- a/fs/utimes.c
> +++ b/fs/utimes.c
> @@ -7,6 +7,7 @@
> #include <linux/uaccess.h>
> #include <linux/compat.h>
> #include <asm/unistd.h>
> +#include <linux/filelock.h>
>=20
> static bool nsec_valid(long nsec)
> {
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 61107b6bbed2..b81fd7d8520e 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -9,6 +9,7 @@
>   Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
>  */
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/slab.h>
> #include <linux/file.h>
> #include <linux/xattr.h>
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index 549c60942208..c1f283cc22f6 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -11,6 +11,7 @@
> #include <linux/spinlock.h>
> #include <linux/mm.h>
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/dax.h>
> #include <linux/uio.h>
> #include <linux/list_lru.h>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e462d39c840e..591c696651f0 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -31,6 +31,7 @@
> #include <linux/mman.h>
> #include <linux/fadvise.h>
> #include <linux/mount.h>
> +#include <linux/filelock.h>
>=20
> static const struct vm_operations_struct xfs_file_vm_ops;
>=20
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index aa303be11576..257e279df469 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -4,6 +4,7 @@
>  * All Rights Reserved.
>  */
> #include <linux/iversion.h>
> +#include <linux/filelock.h>
>=20
> #include "xfs.h"
> #include "xfs_fs.h"
> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> new file mode 100644
> index 000000000000..b686e7e74787
> --- /dev/null
> +++ b/include/linux/filelock.h
> @@ -0,0 +1,428 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FILELOCK_H
> +#define _LINUX_FILELOCK_H
> +
> +#include <linux/list.h>
> +#include <linux/nfs_fs_i.h>
> +
> +#define FL_POSIX	1
> +#define FL_FLOCK	2
> +#define FL_DELEG	4	/* NFSv4 delegation */
> +#define FL_ACCESS	8	/* not trying to lock, just looking */
> +#define FL_EXISTS	16	/* when unlocking, test for existence */
> +#define FL_LEASE	32	/* lease held on this file */
> +#define FL_CLOSE	64	/* unlock on close */
> +#define FL_SLEEP	128	/* A blocking lock */
> +#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
> +#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
> +#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
> +#define FL_LAYOUT	2048	/* outstanding pNFS layout */
> +#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
> +
> +#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> +
> +/*
> + * Special return value from posix_lock_file() and vfs_lock_file() for
> + * asynchronous locking.
> + */
> +#define FILE_LOCK_DEFERRED 1
> +
> +struct file_lock;
> +
> +struct file_lock_operations {
> +	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
> +	void (*fl_release_private)(struct file_lock *);
> +};
> +
> +struct lock_manager_operations {
> +	void *lm_mod_owner;
> +	fl_owner_t (*lm_get_owner)(fl_owner_t);
> +	void (*lm_put_owner)(fl_owner_t);
> +	void (*lm_notify)(struct file_lock *);	/* unblock callback */
> +	int (*lm_grant)(struct file_lock *, int);
> +	bool (*lm_break)(struct file_lock *);
> +	int (*lm_change)(struct file_lock *, int, struct list_head *);
> +	void (*lm_setup)(struct file_lock *, void **);
> +	bool (*lm_breaker_owns_lease)(struct file_lock *);
> +	bool (*lm_lock_expirable)(struct file_lock *cfl);
> +	void (*lm_expire_lock)(void);
> +};
> +
> +struct lock_manager {
> +	struct list_head list;
> +	/*
> +	 * NFSv4 and up also want opens blocked during the grace period;
> +	 * NLM doesn't care:
> +	 */
> +	bool block_opens;
> +};
> +
> +struct net;
> +void locks_start_grace(struct net *, struct lock_manager *);
> +void locks_end_grace(struct lock_manager *);
> +bool locks_in_grace(struct net *);
> +bool opens_in_grace(struct net *);
> +
> +
> +/*
> + * struct file_lock represents a generic "file lock". It's used to repre=
sent
> + * POSIX byte range locks, BSD (flock) locks, and leases. It's important=
 to
> + * note that the same struct is used to represent both a request for a l=
ock and
> + * the lock itself, but the same object is never used for both.
> + *
> + * FIXME: should we create a separate "struct lock_request" to help dist=
inguish
> + * these two uses?
> + *
> + * The varous i_flctx lists are ordered by:
> + *
> + * 1) lock owner
> + * 2) lock range start
> + * 3) lock range end
> + *
> + * Obviously, the last two criteria only matter for POSIX locks.
> + */
> +struct file_lock {
> +	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
> +	struct list_head fl_list;	/* link into file_lock_context */
> +	struct hlist_node fl_link;	/* node in global lists */
> +	struct list_head fl_blocked_requests;	/* list of requests with
> +						 * ->fl_blocker pointing here
> +						 */
> +	struct list_head fl_blocked_member;	/* node in
> +						 * ->fl_blocker->fl_blocked_requests
> +						 */
> +	fl_owner_t fl_owner;
> +	unsigned int fl_flags;
> +	unsigned char fl_type;
> +	unsigned int fl_pid;
> +	int fl_link_cpu;		/* what cpu's list is this on? */
> +	wait_queue_head_t fl_wait;
> +	struct file *fl_file;
> +	loff_t fl_start;
> +	loff_t fl_end;
> +
> +	struct fasync_struct *	fl_fasync; /* for lease break notifications */
> +	/* for lease breaks: */
> +	unsigned long fl_break_time;
> +	unsigned long fl_downgrade_time;
> +
> +	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems=
 */
> +	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockma=
nagers */
> +	union {
> +		struct nfs_lock_info	nfs_fl;
> +		struct nfs4_lock_info	nfs4_fl;
> +		struct {
> +			struct list_head link;	/* link in AFS vnode's pending_locks list */
> +			int state;		/* state of grant or error if -ve */
> +			unsigned int	debug_id;
> +		} afs;
> +	} fl_u;
> +} __randomize_layout;
> +
> +struct file_lock_context {
> +	spinlock_t		flc_lock;
> +	struct list_head	flc_flock;
> +	struct list_head	flc_posix;
> +	struct list_head	flc_lease;
> +};
> +
> +#define locks_inode(f) file_inode(f)
> +
> +#ifdef CONFIG_FILE_LOCKING
> +extern int fcntl_getlk(struct file *, unsigned int, struct flock *);
> +extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
> +			struct flock *);
> +
> +#if BITS_PER_LONG =3D=3D 32
> +extern int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
> +extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> +			struct flock64 *);
> +#endif
> +
> +extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
> +extern int fcntl_getlease(struct file *filp);
> +
> +/* fs/locks.c */
> +void locks_free_lock_context(struct inode *inode);
> +void locks_free_lock(struct file_lock *fl);
> +extern void locks_init_lock(struct file_lock *);
> +extern struct file_lock * locks_alloc_lock(void);
> +extern void locks_copy_lock(struct file_lock *, struct file_lock *);
> +extern void locks_copy_conflock(struct file_lock *, struct file_lock *);
> +extern void locks_remove_posix(struct file *, fl_owner_t);
> +extern void locks_remove_file(struct file *);
> +extern void locks_release_private(struct file_lock *);
> +extern void posix_test_lock(struct file *, struct file_lock *);
> +extern int posix_lock_file(struct file *, struct file_lock *, struct fil=
e_lock *);
> +extern int locks_delete_block(struct file_lock *);
> +extern int vfs_test_lock(struct file *, struct file_lock *);
> +extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *=
, struct file_lock *);
> +extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> +bool vfs_inode_has_locks(struct inode *inode);
> +extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *=
fl);
> +extern int __break_lease(struct inode *inode, unsigned int flags, unsign=
ed int type);
> +extern void lease_get_mtime(struct inode *, struct timespec64 *time);
> +extern int generic_setlease(struct file *, long, struct file_lock **, vo=
id **priv);
> +extern int vfs_setlease(struct file *, long, struct file_lock **, void *=
*);
> +extern int lease_modify(struct file_lock *, int, struct list_head *);
> +
> +struct notifier_block;
> +extern int lease_register_notifier(struct notifier_block *);
> +extern void lease_unregister_notifier(struct notifier_block *);
> +
> +struct files_struct;
> +extern void show_fd_locks(struct seq_file *f,
> +			 struct file *filp, struct files_struct *files);
> +extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> +			fl_owner_t owner);
> +
> +static inline struct file_lock_context *
> +locks_inode_context(const struct inode *inode)
> +{
> +	return smp_load_acquire(&inode->i_flctx);
> +}
> +
> +#else /* !CONFIG_FILE_LOCKING */
> +static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> +			      struct flock __user *user)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int fcntl_setlk(unsigned int fd, struct file *file,
> +			      unsigned int cmd, struct flock __user *user)
> +{
> +	return -EACCES;
> +}
> +
> +#if BITS_PER_LONG =3D=3D 32
> +static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
> +				struct flock64 *user)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int fcntl_setlk64(unsigned int fd, struct file *file,
> +				unsigned int cmd, struct flock64 *user)
> +{
> +	return -EACCES;
> +}
> +#endif
> +static inline int fcntl_setlease(unsigned int fd, struct file *filp, lon=
g arg)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int fcntl_getlease(struct file *filp)
> +{
> +	return F_UNLCK;
> +}
> +
> +static inline void
> +locks_free_lock_context(struct inode *inode)
> +{
> +}
> +
> +static inline void locks_init_lock(struct file_lock *fl)
> +{
> +	return;
> +}
> +
> +static inline void locks_copy_conflock(struct file_lock *new, struct fil=
e_lock *fl)
> +{
> +	return;
> +}
> +
> +static inline void locks_copy_lock(struct file_lock *new, struct file_lo=
ck *fl)
> +{
> +	return;
> +}
> +
> +static inline void locks_remove_posix(struct file *filp, fl_owner_t owne=
r)
> +{
> +	return;
> +}
> +
> +static inline void locks_remove_file(struct file *filp)
> +{
> +	return;
> +}
> +
> +static inline void posix_test_lock(struct file *filp, struct file_lock *=
fl)
> +{
> +	return;
> +}
> +
> +static inline int posix_lock_file(struct file *filp, struct file_lock *f=
l,
> +				  struct file_lock *conflock)
> +{
> +	return -ENOLCK;
> +}
> +
> +static inline int locks_delete_block(struct file_lock *waiter)
> +{
> +	return -ENOENT;
> +}
> +
> +static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
> +{
> +	return 0;
> +}
> +
> +static inline int vfs_lock_file(struct file *filp, unsigned int cmd,
> +				struct file_lock *fl, struct file_lock *conf)
> +{
> +	return -ENOLCK;
> +}
> +
> +static inline int vfs_cancel_lock(struct file *filp, struct file_lock *f=
l)
> +{
> +	return 0;
> +}
> +
> +static inline int locks_lock_inode_wait(struct inode *inode, struct file=
_lock *fl)
> +{
> +	return -ENOLCK;
> +}
> +
> +static inline int __break_lease(struct inode *inode, unsigned int mode, =
unsigned int type)
> +{
> +	return 0;
> +}
> +
> +static inline void lease_get_mtime(struct inode *inode,
> +				   struct timespec64 *time)
> +{
> +	return;
> +}
> +
> +static inline int generic_setlease(struct file *filp, long arg,
> +				    struct file_lock **flp, void **priv)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int vfs_setlease(struct file *filp, long arg,
> +			       struct file_lock **lease, void **priv)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int lease_modify(struct file_lock *fl, int arg,
> +			       struct list_head *dispose)
> +{
> +	return -EINVAL;
> +}
> +
> +struct files_struct;
> +static inline void show_fd_locks(struct seq_file *f,
> +			struct file *filp, struct files_struct *files) {}
> +static inline bool locks_owner_has_blockers(struct file_lock_context *fl=
ctx,
> +			fl_owner_t owner)
> +{
> +	return false;
> +}
> +
> +static inline struct file_lock_context *
> +locks_inode_context(const struct inode *inode)
> +{
> +	return NULL;
> +}
> +#endif /* !CONFIG_FILE_LOCKING */
> +
> +static inline int locks_lock_file_wait(struct file *filp, struct file_lo=
ck *fl)
> +{
> +	return locks_lock_inode_wait(locks_inode(filp), fl);
> +}
> +
> +#ifdef CONFIG_FILE_LOCKING
> +static inline int break_lease(struct inode *inode, unsigned int mode)
> +{
> +	/*
> +	 * Since this check is lockless, we must ensure that any refcounts
> +	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
> +	 * could end up racing with tasks trying to set a new lease on this
> +	 * file.
> +	 */
> +	smp_mb();
> +	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +		return __break_lease(inode, mode, FL_LEASE);
> +	return 0;
> +}
> +
> +static inline int break_deleg(struct inode *inode, unsigned int mode)
> +{
> +	/*
> +	 * Since this check is lockless, we must ensure that any refcounts
> +	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
> +	 * could end up racing with tasks trying to set a new lease on this
> +	 * file.
> +	 */
> +	smp_mb();
> +	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +		return __break_lease(inode, mode, FL_DELEG);
> +	return 0;
> +}
> +
> +static inline int try_break_deleg(struct inode *inode, struct inode **de=
legated_inode)
> +{
> +	int ret;
> +
> +	ret =3D break_deleg(inode, O_WRONLY|O_NONBLOCK);
> +	if (ret =3D=3D -EWOULDBLOCK && delegated_inode) {
> +		*delegated_inode =3D inode;
> +		ihold(inode);
> +	}
> +	return ret;
> +}
> +
> +static inline int break_deleg_wait(struct inode **delegated_inode)
> +{
> +	int ret;
> +
> +	ret =3D break_deleg(*delegated_inode, O_WRONLY);
> +	iput(*delegated_inode);
> +	*delegated_inode =3D NULL;
> +	return ret;
> +}
> +
> +static inline int break_layout(struct inode *inode, bool wait)
> +{
> +	smp_mb();
> +	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> +		return __break_lease(inode,
> +				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
> +				FL_LAYOUT);
> +	return 0;
> +}
> +
> +#else /* !CONFIG_FILE_LOCKING */
> +static inline int break_lease(struct inode *inode, unsigned int mode)
> +{
> +	return 0;
> +}
> +
> +static inline int break_deleg(struct inode *inode, unsigned int mode)
> +{
> +	return 0;
> +}
> +
> +static inline int try_break_deleg(struct inode *inode, struct inode **de=
legated_inode)
> +{
> +	return 0;
> +}
> +
> +static inline int break_deleg_wait(struct inode **delegated_inode)
> +{
> +	BUG();
> +	return 0;
> +}
> +
> +static inline int break_layout(struct inode *inode, bool wait)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_FILE_LOCKING */
> +
> +#endif /* _LINUX_FILELOCK_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 092673178e13..63f355058ab5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1003,132 +1003,11 @@ static inline struct file *get_file(struct file =
*f)
> #define MAX_LFS_FILESIZE 	((loff_t)LLONG_MAX)
> #endif
>=20
> -#define FL_POSIX	1
> -#define FL_FLOCK	2
> -#define FL_DELEG	4	/* NFSv4 delegation */
> -#define FL_ACCESS	8	/* not trying to lock, just looking */
> -#define FL_EXISTS	16	/* when unlocking, test for existence */
> -#define FL_LEASE	32	/* lease held on this file */
> -#define FL_CLOSE	64	/* unlock on close */
> -#define FL_SLEEP	128	/* A blocking lock */
> -#define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
> -#define FL_UNLOCK_PENDING	512 /* Lease is being broken */
> -#define FL_OFDLCK	1024	/* lock is "owned" by struct file */
> -#define FL_LAYOUT	2048	/* outstanding pNFS layout */
> -#define FL_RECLAIM	4096	/* reclaiming from a reboot server */
> -
> -#define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
> -
> -/*
> - * Special return value from posix_lock_file() and vfs_lock_file() for
> - * asynchronous locking.
> - */
> -#define FILE_LOCK_DEFERRED 1
> -
> /* legacy typedef, should eventually be removed */
> typedef void *fl_owner_t;
>=20
> struct file_lock;
>=20
> -struct file_lock_operations {
> -	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
> -	void (*fl_release_private)(struct file_lock *);
> -};
> -
> -struct lock_manager_operations {
> -	void *lm_mod_owner;
> -	fl_owner_t (*lm_get_owner)(fl_owner_t);
> -	void (*lm_put_owner)(fl_owner_t);
> -	void (*lm_notify)(struct file_lock *);	/* unblock callback */
> -	int (*lm_grant)(struct file_lock *, int);
> -	bool (*lm_break)(struct file_lock *);
> -	int (*lm_change)(struct file_lock *, int, struct list_head *);
> -	void (*lm_setup)(struct file_lock *, void **);
> -	bool (*lm_breaker_owns_lease)(struct file_lock *);
> -	bool (*lm_lock_expirable)(struct file_lock *cfl);
> -	void (*lm_expire_lock)(void);
> -};
> -
> -struct lock_manager {
> -	struct list_head list;
> -	/*
> -	 * NFSv4 and up also want opens blocked during the grace period;
> -	 * NLM doesn't care:
> -	 */
> -	bool block_opens;
> -};
> -
> -struct net;
> -void locks_start_grace(struct net *, struct lock_manager *);
> -void locks_end_grace(struct lock_manager *);
> -bool locks_in_grace(struct net *);
> -bool opens_in_grace(struct net *);
> -
> -/* that will die - we need it for nfs_lock_info */
> -#include <linux/nfs_fs_i.h>
> -
> -/*
> - * struct file_lock represents a generic "file lock". It's used to repre=
sent
> - * POSIX byte range locks, BSD (flock) locks, and leases. It's important=
 to
> - * note that the same struct is used to represent both a request for a l=
ock and
> - * the lock itself, but the same object is never used for both.
> - *
> - * FIXME: should we create a separate "struct lock_request" to help dist=
inguish
> - * these two uses?
> - *
> - * The varous i_flctx lists are ordered by:
> - *
> - * 1) lock owner
> - * 2) lock range start
> - * 3) lock range end
> - *
> - * Obviously, the last two criteria only matter for POSIX locks.
> - */
> -struct file_lock {
> -	struct file_lock *fl_blocker;	/* The lock, that is blocking us */
> -	struct list_head fl_list;	/* link into file_lock_context */
> -	struct hlist_node fl_link;	/* node in global lists */
> -	struct list_head fl_blocked_requests;	/* list of requests with
> -						 * ->fl_blocker pointing here
> -						 */
> -	struct list_head fl_blocked_member;	/* node in
> -						 * ->fl_blocker->fl_blocked_requests
> -						 */
> -	fl_owner_t fl_owner;
> -	unsigned int fl_flags;
> -	unsigned char fl_type;
> -	unsigned int fl_pid;
> -	int fl_link_cpu;		/* what cpu's list is this on? */
> -	wait_queue_head_t fl_wait;
> -	struct file *fl_file;
> -	loff_t fl_start;
> -	loff_t fl_end;
> -
> -	struct fasync_struct *	fl_fasync; /* for lease break notifications */
> -	/* for lease breaks: */
> -	unsigned long fl_break_time;
> -	unsigned long fl_downgrade_time;
> -
> -	const struct file_lock_operations *fl_ops;	/* Callbacks for filesystems=
 */
> -	const struct lock_manager_operations *fl_lmops;	/* Callbacks for lockma=
nagers */
> -	union {
> -		struct nfs_lock_info	nfs_fl;
> -		struct nfs4_lock_info	nfs4_fl;
> -		struct {
> -			struct list_head link;	/* link in AFS vnode's pending_locks list */
> -			int state;		/* state of grant or error if -ve */
> -			unsigned int	debug_id;
> -		} afs;
> -	} fl_u;
> -} __randomize_layout;
> -
> -struct file_lock_context {
> -	spinlock_t		flc_lock;
> -	struct list_head	flc_flock;
> -	struct list_head	flc_posix;
> -	struct list_head	flc_lease;
> -};
> -
> /* The following constant reflects the upper bound of the file/locking sp=
ace */
> #ifndef OFFSET_MAX
> #define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
> @@ -1138,211 +1017,6 @@ struct file_lock_context {
>=20
> extern void send_sigio(struct fown_struct *fown, int fd, int band);
>=20
> -#define locks_inode(f) file_inode(f)
> -
> -#ifdef CONFIG_FILE_LOCKING
> -extern int fcntl_getlk(struct file *, unsigned int, struct flock *);
> -extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
> -			struct flock *);
> -
> -#if BITS_PER_LONG =3D=3D 32
> -extern int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
> -extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> -			struct flock64 *);
> -#endif
> -
> -extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
> -extern int fcntl_getlease(struct file *filp);
> -
> -/* fs/locks.c */
> -void locks_free_lock_context(struct inode *inode);
> -void locks_free_lock(struct file_lock *fl);
> -extern void locks_init_lock(struct file_lock *);
> -extern struct file_lock * locks_alloc_lock(void);
> -extern void locks_copy_lock(struct file_lock *, struct file_lock *);
> -extern void locks_copy_conflock(struct file_lock *, struct file_lock *);
> -extern void locks_remove_posix(struct file *, fl_owner_t);
> -extern void locks_remove_file(struct file *);
> -extern void locks_release_private(struct file_lock *);
> -extern void posix_test_lock(struct file *, struct file_lock *);
> -extern int posix_lock_file(struct file *, struct file_lock *, struct fil=
e_lock *);
> -extern int locks_delete_block(struct file_lock *);
> -extern int vfs_test_lock(struct file *, struct file_lock *);
> -extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *=
, struct file_lock *);
> -extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> -bool vfs_inode_has_locks(struct inode *inode);
> -extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *=
fl);
> -extern int __break_lease(struct inode *inode, unsigned int flags, unsign=
ed int type);
> -extern void lease_get_mtime(struct inode *, struct timespec64 *time);
> -extern int generic_setlease(struct file *, long, struct file_lock **, vo=
id **priv);
> -extern int vfs_setlease(struct file *, long, struct file_lock **, void *=
*);
> -extern int lease_modify(struct file_lock *, int, struct list_head *);
> -
> -struct notifier_block;
> -extern int lease_register_notifier(struct notifier_block *);
> -extern void lease_unregister_notifier(struct notifier_block *);
> -
> -struct files_struct;
> -extern void show_fd_locks(struct seq_file *f,
> -			 struct file *filp, struct files_struct *files);
> -extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
> -			fl_owner_t owner);
> -
> -static inline struct file_lock_context *
> -locks_inode_context(const struct inode *inode)
> -{
> -	return smp_load_acquire(&inode->i_flctx);
> -}
> -
> -#else /* !CONFIG_FILE_LOCKING */
> -static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> -			      struct flock __user *user)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int fcntl_setlk(unsigned int fd, struct file *file,
> -			      unsigned int cmd, struct flock __user *user)
> -{
> -	return -EACCES;
> -}
> -
> -#if BITS_PER_LONG =3D=3D 32
> -static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
> -				struct flock64 *user)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int fcntl_setlk64(unsigned int fd, struct file *file,
> -				unsigned int cmd, struct flock64 *user)
> -{
> -	return -EACCES;
> -}
> -#endif
> -static inline int fcntl_setlease(unsigned int fd, struct file *filp, lon=
g arg)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int fcntl_getlease(struct file *filp)
> -{
> -	return F_UNLCK;
> -}
> -
> -static inline void
> -locks_free_lock_context(struct inode *inode)
> -{
> -}
> -
> -static inline void locks_init_lock(struct file_lock *fl)
> -{
> -	return;
> -}
> -
> -static inline void locks_copy_conflock(struct file_lock *new, struct fil=
e_lock *fl)
> -{
> -	return;
> -}
> -
> -static inline void locks_copy_lock(struct file_lock *new, struct file_lo=
ck *fl)
> -{
> -	return;
> -}
> -
> -static inline void locks_remove_posix(struct file *filp, fl_owner_t owne=
r)
> -{
> -	return;
> -}
> -
> -static inline void locks_remove_file(struct file *filp)
> -{
> -	return;
> -}
> -
> -static inline void posix_test_lock(struct file *filp, struct file_lock *=
fl)
> -{
> -	return;
> -}
> -
> -static inline int posix_lock_file(struct file *filp, struct file_lock *f=
l,
> -				  struct file_lock *conflock)
> -{
> -	return -ENOLCK;
> -}
> -
> -static inline int locks_delete_block(struct file_lock *waiter)
> -{
> -	return -ENOENT;
> -}
> -
> -static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
> -{
> -	return 0;
> -}
> -
> -static inline int vfs_lock_file(struct file *filp, unsigned int cmd,
> -				struct file_lock *fl, struct file_lock *conf)
> -{
> -	return -ENOLCK;
> -}
> -
> -static inline int vfs_cancel_lock(struct file *filp, struct file_lock *f=
l)
> -{
> -	return 0;
> -}
> -
> -static inline int locks_lock_inode_wait(struct inode *inode, struct file=
_lock *fl)
> -{
> -	return -ENOLCK;
> -}
> -
> -static inline int __break_lease(struct inode *inode, unsigned int mode, =
unsigned int type)
> -{
> -	return 0;
> -}
> -
> -static inline void lease_get_mtime(struct inode *inode,
> -				   struct timespec64 *time)
> -{
> -	return;
> -}
> -
> -static inline int generic_setlease(struct file *filp, long arg,
> -				    struct file_lock **flp, void **priv)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int vfs_setlease(struct file *filp, long arg,
> -			       struct file_lock **lease, void **priv)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline int lease_modify(struct file_lock *fl, int arg,
> -			       struct list_head *dispose)
> -{
> -	return -EINVAL;
> -}
> -
> -struct files_struct;
> -static inline void show_fd_locks(struct seq_file *f,
> -			struct file *filp, struct files_struct *files) {}
> -static inline bool locks_owner_has_blockers(struct file_lock_context *fl=
ctx,
> -			fl_owner_t owner)
> -{
> -	return false;
> -}
> -
> -static inline struct file_lock_context *
> -locks_inode_context(const struct inode *inode)
> -{
> -	return NULL;
> -}
> -
> -#endif /* !CONFIG_FILE_LOCKING */
> -
> static inline struct inode *file_inode(const struct file *f)
> {
> 	return f->f_inode;
> @@ -1353,11 +1027,6 @@ static inline struct dentry *file_dentry(const str=
uct file *file)
> 	return d_real(file->f_path.dentry, file_inode(file));
> }
>=20
> -static inline int locks_lock_file_wait(struct file *filp, struct file_lo=
ck *fl)
> -{
> -	return locks_lock_inode_wait(locks_inode(filp), fl);
> -}
> -
> struct fasync_struct {
> 	rwlock_t		fa_lock;
> 	int			magic;
> @@ -2641,96 +2310,6 @@ extern struct kobject *fs_kobj;
>=20
> #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)
>=20
> -#ifdef CONFIG_FILE_LOCKING
> -static inline int break_lease(struct inode *inode, unsigned int mode)
> -{
> -	/*
> -	 * Since this check is lockless, we must ensure that any refcounts
> -	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
> -	 * could end up racing with tasks trying to set a new lease on this
> -	 * file.
> -	 */
> -	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> -		return __break_lease(inode, mode, FL_LEASE);
> -	return 0;
> -}
> -
> -static inline int break_deleg(struct inode *inode, unsigned int mode)
> -{
> -	/*
> -	 * Since this check is lockless, we must ensure that any refcounts
> -	 * taken are done before checking i_flctx->flc_lease. Otherwise, we
> -	 * could end up racing with tasks trying to set a new lease on this
> -	 * file.
> -	 */
> -	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> -		return __break_lease(inode, mode, FL_DELEG);
> -	return 0;
> -}
> -
> -static inline int try_break_deleg(struct inode *inode, struct inode **de=
legated_inode)
> -{
> -	int ret;
> -
> -	ret =3D break_deleg(inode, O_WRONLY|O_NONBLOCK);
> -	if (ret =3D=3D -EWOULDBLOCK && delegated_inode) {
> -		*delegated_inode =3D inode;
> -		ihold(inode);
> -	}
> -	return ret;
> -}
> -
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> -{
> -	int ret;
> -
> -	ret =3D break_deleg(*delegated_inode, O_WRONLY);
> -	iput(*delegated_inode);
> -	*delegated_inode =3D NULL;
> -	return ret;
> -}
> -
> -static inline int break_layout(struct inode *inode, bool wait)
> -{
> -	smp_mb();
> -	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
> -		return __break_lease(inode,
> -				wait ? O_WRONLY : O_WRONLY | O_NONBLOCK,
> -				FL_LAYOUT);
> -	return 0;
> -}
> -
> -#else /* !CONFIG_FILE_LOCKING */
> -static inline int break_lease(struct inode *inode, unsigned int mode)
> -{
> -	return 0;
> -}
> -
> -static inline int break_deleg(struct inode *inode, unsigned int mode)
> -{
> -	return 0;
> -}
> -
> -static inline int try_break_deleg(struct inode *inode, struct inode **de=
legated_inode)
> -{
> -	return 0;
> -}
> -
> -static inline int break_deleg_wait(struct inode **delegated_inode)
> -{
> -	BUG();
> -	return 0;
> -}
> -
> -static inline int break_layout(struct inode *inode, bool wait)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_FILE_LOCKING */
> -
> /* fs/open.c */
> struct audit_names;
> struct filename {
> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> index 67e4a2c5500b..b60fbcd8cdfa 100644
> --- a/include/linux/lockd/xdr.h
> +++ b/include/linux/lockd/xdr.h
> @@ -11,6 +11,7 @@
> #define LOCKD_XDR_H
>=20
> #include <linux/fs.h>
> +#include <linux/filelock.h>
> #include <linux/nfs.h>
> #include <linux/sunrpc/xdr.h>
>=20
> --=20
> 2.38.1
>=20

--
Chuck Lever



