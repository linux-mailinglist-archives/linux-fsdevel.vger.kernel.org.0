Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92EA5F5580
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJENeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJENeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:34:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA117A752;
        Wed,  5 Oct 2022 06:34:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295AMrp5021627;
        Wed, 5 Oct 2022 13:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ss898Cn+oYhDmuFOsMH2l22rPVGB/sOjJaJ+ZkK12/w=;
 b=wGbj6fSFZkt1boFM40bviX2BWuiGkanA/pmAzkWaWTWANz1bRTtnsp56aWSVyfIMxtUs
 l+ryGu2X1UduU0tVN6fZ5s8N2pruTnZTDLvkvqomZdSPwoH/tVEVUZh0w7QvwpzHOv0H
 CcrGBRCxSmGFkv4/jjkJSLVmZgW1MMOOQd8/Mo1WPWhck+BwvmVsgx233fn+b15pB9z+
 VPHHG+bzgB1smilpZmGnPXCG4ptgmmo9+Wb3+XCtVVqdabWDGbihd6s1wnmePetj4y54
 Ylt2DDQ8ujzRzLNaaV1KR2xzfTcvtvT362x9H1kLl0cQbygCIR1dkq2oS0K4i3jrYMY0 OA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2s8s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 13:33:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2959sujQ027294;
        Wed, 5 Oct 2022 13:33:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc055182-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 13:33:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO8N0bv8ayd5IoYFJyPl3/lL6H2npZ1Nhn7FwKB+tZqgTyg/ftbmRfuQjE0DaN7UJt0/Mrk0R74pKW0VCbkJWfovzL57EwNEIGcXHtJwdCEcKpAZAtSbfVNMesgnVf9umL7fn6Vve/THJaAWklVFGufOwOiwvJaPez058TbCqATacAFjfnyzLQoStJLDjr24rT4t86l4749g/qaGLdNhPI1jxA+KycCTEzLRPaUDIhCPx/xwF46WKvnwl9goEYP7gI/JRudFZ3YgSx47pzhSb4EcgSARRlkF51FpTWtKhMz+FhzGon/oS7iD4h2smmIsc/z8UDOwJ2pRCjxFGZqbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss898Cn+oYhDmuFOsMH2l22rPVGB/sOjJaJ+ZkK12/w=;
 b=ZZDIClytO2UdIOn3XEK50EH7LYfJGP4VvB0HmZ0/y3sI+B55J6YtqKI3YlUXlhiFre7NkqQD4Ao9xeRYrz1cLtKB/X3RD9MtRNAJCZDCbUP5PqcRPvQCoVDhPgPTowoZXfhGKYNO+1e06GO/rp7VKAFVvjlCFBfOp4NXxr69zKcOHZ7QGvxRt7fDIrvW87nX1/I8q5Q4Qc6OFZ7QiZZ9G4Jr/Gcau46nZ3uYfA3e89QDx07gMOumNkDqOtKr62eAAnA/jttH9cLHt0wKeUbeC0sZswNYwlc0hZS/Mo3/mtjsmW18ilzZbebro4OQCOn14EUVOW9Pi+XFgnfpoBHdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss898Cn+oYhDmuFOsMH2l22rPVGB/sOjJaJ+ZkK12/w=;
 b=hK9/OAVEQb4bFfLtjWS3aRir++pkuwz0GnHmS384TSXA59MIYGU8UlY9IzyomLlyhS6O7R8P+Ak1KMyOyC5J0q/uunUQk3anMimujxa24QWXrmG/st0w3Bk1vXxx9QUfUm7tEOnviMgUYdqwR3FmoY2W/qbyn9OVAGsTPSPNJIs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 5 Oct
 2022 13:33:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 13:33:43 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Neil Brown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] nfsd: use the getattr operation to fetch i_version
Thread-Topic: [PATCH v6 6/9] nfsd: use the getattr operation to fetch
 i_version
Thread-Index: AQHY1L5ywUre48g23kmtI4qfGBpQE639WS2AgAJBsgCAADnPAA==
Date:   Wed, 5 Oct 2022 13:33:43 +0000
Message-ID: <8472C4CD-AFE4-484D-868E-0DAA3406D0BE@oracle.com>
References: <20220930111840.10695-1-jlayton@kernel.org>
 <20220930111840.10695-7-jlayton@kernel.org>
 <166484034920.14457.15225090674729127890@noble.neil.brown.name>
 <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
In-Reply-To: <13714490816df1ff36ab06bbf32df5440cad7913.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5004:EE_
x-ms-office365-filtering-correlation-id: 5f09ec9f-8d5f-41b3-c5d9-08daa6d638c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzf8Ueg0L47JYg/lJjpr7PVDyyQpkADQwz25qNNlkgCQBwoF7uCQCa2R+Oozlq4g6S3VZWKWRW31iSmEYUaG5aU919qdVwRtmK5vTxWg1BJlI9RCNKQWp5lN1uFqpYcRpFVMIKT7TEq+rZaifB80eBOp4zPQajzpxR/dXqnBINkr3rHLYNnzGJwoy0BHBbwJ0whJ7CwgVEDwa/8xNiTsRDQVEUTBXZc09tfUH2VmO5mQdQ/OGkJx3ZXFTDS/G/ps4UUIQ7miQFE57sEGyL96AtBog7qDoLn3cQNQW1xBSU7B3sjTY8b7v5TY4+3D/KHOY0SqjsylVmPCNld7bpU+wXDo1w48ZkNjfMaBQv1kBJA5IgK+/QjzIcU7W3ROj0QMCiobynqomQLP3dBBvk0sRQp7XI1jz3DKqyQ+tzAqd09Myfw/owwyDqk1zNhatgMxzprzITU0anWHZh1ah7GfUZv0neesPu3qhiONJ5WvgHu/mZ7q6XWw3PUoa5wtEsCWZdOdzrrNzNfK9C21ZKfn2qlajAXQ6O3He/ab4n3pMNFPR6B+baSuyInro1Lv7nt9wv0YC42cg3J2/BWX79qtKZ0ACIf3esxwc+L+hAUWX2E7vbu36KtkjrXi4QPL66woa7w5TIHXpQ2sIjCbkddAJmdhFnJ0sd2BWLfaEjII5QiW+C0fumhBkqanetH2YZXeSlaCofBGOUF4dAFUztrqyQFgg4goRQzkrxcKw2416nVK4x8Rm1FsjAkxfCYpR3fnJlCmbQX2RA4ktCP6ZlDTQVoXmxrDoCSCb+OZWruakRM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(33656002)(2616005)(2906002)(36756003)(66446008)(38100700002)(186003)(122000001)(38070700005)(86362001)(91956017)(66946007)(76116006)(316002)(66556008)(66476007)(6486002)(8676002)(54906003)(478600001)(6512007)(53546011)(66899015)(5660300002)(4326008)(26005)(6916009)(71200400001)(4744005)(41300700001)(8936002)(6506007)(64756008)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hoL2FK3UfcCrM8+/qs1JzStjUvKzYvU3rySmNFaORZYHD1205ZyY38YldQ2D?=
 =?us-ascii?Q?HnAfb4AX2Z0OIv0Jnl5r+CXqvn3Jo+n4vuKy+W/g6vG8u9BW1xQ/l2nuneYU?=
 =?us-ascii?Q?7HRQBYth/Kwourthf2Gs+cv9bNLKjsShWjAi2sPR/AK7sV1ZodCbQNWQkzLj?=
 =?us-ascii?Q?RNlEcSDEua9eenKMHKaCyqpEns4SWpMUl0RD6zhOF2JQ7XaE8g/Vaby5Q0YL?=
 =?us-ascii?Q?TiD8K6gTukyId/ok28Y/LQKrJu/6On0c0+RfrM5b2DaSSg7J11fe8AV6p7Mi?=
 =?us-ascii?Q?ZMjqrb+QvSdmd4l4a9KiwE1A0eeltYJK4d60KQ+Rz3fL7RU3UXBC5MT7Mq1B?=
 =?us-ascii?Q?X5VkPm4xTXI0fOjMDgORtVVazSbHhOpdakr3T71cCV4f/8I6W+ZenrEWRbbP?=
 =?us-ascii?Q?Se+w5QfYMHzFWGlkCmGrBWvjAD6nfyo6MKFt8wd47LuM/+FFTivvHUbhgZRm?=
 =?us-ascii?Q?WvU3/m6slteTmpFZzNyJmMl1ExzlnTaaS3EmXMJi1i7vvpMqR3lTGrag7Ni4?=
 =?us-ascii?Q?qmsqzV0BstfISGJYWGUYQTCCgc56pqOieot+SI84juyNMajluZNo84oo2gAB?=
 =?us-ascii?Q?X3QD2svTMHqmMDAEYyWPDzbN4CXiUw/5yt/GgJ5zJZMyFDibT529ADDjNw7L?=
 =?us-ascii?Q?0nZM3dy4NOATvj9JgH2gTje0d9n5D/9XLoaOkjf2rR5+N+fElWVGNMBt9kZn?=
 =?us-ascii?Q?wczLcU1C4f3T/g4Hy/T6aYOGkbS/4JOcSwBuN44kB9UUP/b4ZEc/+tuTZPHp?=
 =?us-ascii?Q?+TtzStuiWpD3C53zn5aifUaw+M1q1gemPdgABMPTqAf8R20L4PTCQQb4uwZg?=
 =?us-ascii?Q?p49qXzCSiG62eO9jS0KWCsxS5pnMkJZHZBrFdINANbN53B5A4NZa5rDt+v86?=
 =?us-ascii?Q?YToGEYthZ1hIAcbl27xk3bjTIV+TkY6/SUy3sSnnT/8XeJnr95XRuL+Tergt?=
 =?us-ascii?Q?pH3l6OFXJ6bQC9fj4tSoQg7tnhXjm44ans6T9a2gHB7VWA0HQoWN+cURLPZH?=
 =?us-ascii?Q?10xXTlo+c0J82jM7Z4HEkRSOxiumko3iu+GCagdsshuA1VydP/7O+kuuuQn6?=
 =?us-ascii?Q?iOxgdzlwKGFlVegxdyuh7szGTkOEDZrAMALKXxZTToggvY2WpqG7g70BCzBB?=
 =?us-ascii?Q?8IQUHdQ5xVOVyHlPIik6li0FHN+VO6OzybW7IXF0dlvwy1YH1HZ4yzM0VLdU?=
 =?us-ascii?Q?Gc2wZoMkTheKxyt+r6kC7D6SHOVtthiKIX2WNdAgzvhL8mipv13tFTpSgTbP?=
 =?us-ascii?Q?J9httGp9NmtrRvJNZEaFybLgHzPsJ8fcotX0RfGzo+nb1QnsCRZNJrBQ1bc3?=
 =?us-ascii?Q?nNQrVgh8HzFBfe6Z8ZavZYdPBgaBB0PISPam+RoRufKVWFO0w7SMNGASEjnB?=
 =?us-ascii?Q?xYEp4b173+Rv2yYgB0o/9HDtwX6SRmP0uSjmkcebUnq1cf4skSbGpFQRlBhx?=
 =?us-ascii?Q?k4URZ8iFdGVJoXkNrNeqafMUkbeJvtg7nM5N7DhPACnJvR5RzBQEQZ9elVD/?=
 =?us-ascii?Q?oZ/Lh4eRAAFiu2sQo1KfR14DC/o24kwnXpt171Kzjf9obNsHBdswEBHYhD0k?=
 =?us-ascii?Q?6kpXjK3XSgArV1KQGW+y6ntOBo14mPjzgn3wGoUGNrdAuB4K4pmmhJ/YuEi8?=
 =?us-ascii?Q?ig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D8A552E0DE50649AE10028F343F3CAD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PMcbZZ/usDWPvF7JuEVWZDV2hYmWWsn27VHyQbb+LFCkTxYWgyYljtbZDQv2?=
 =?us-ascii?Q?1y/TW8kik7h0jB4y6q3SmvAxwoxP0SsvORloy3eCuOuiG9dJTzl6uUz1k/f5?=
 =?us-ascii?Q?VdaJhTloll78GJTARdyDVmvMmtN5xa//Q3x/JjftOBr34RtDKFgSLId5n4cD?=
 =?us-ascii?Q?5mM0/lGNI1vBJ3oxLvQsHdEKFgorzHhwmypUjNMj9WV9G2tOKflnSuXjwTCd?=
 =?us-ascii?Q?C520FrbngWIzJHYanR0FQbJneMzf8y7iiWPLSArHKaFFUYs3hItb406Ib92e?=
 =?us-ascii?Q?iZyZFGVeM3TzSyUwwupsJhYJFXO1u5c+XvELdiy9alhiIsx+UibFrvVVznsp?=
 =?us-ascii?Q?i6jYs8KGZpHUqP8x44RyPquaoLqUs71mAIinnRXin2WNduCu2wa5DMEQRQhd?=
 =?us-ascii?Q?KaDI+G1WVc9oEkThIBSGI3eT1geFZVub6qZwlbhj9A9TUozU0UOolZJPbAmF?=
 =?us-ascii?Q?fETrzQ3UXr9ehSgU2VLqswsvVqDAzXqPuOqmWyCzOKJjjGCpld9qaYUrTp5s?=
 =?us-ascii?Q?fZ5PYYPm8HUQ5t8V/gSow4n3WkIqiSqycRuH28lUYr954Jp/JbPxAs1mZ4Om?=
 =?us-ascii?Q?yWR6mW02xyIxJgdFfzcV0se288F9KGG52VS2J/axtchaOSpB7ElfAcVK4nx8?=
 =?us-ascii?Q?WIqKCtbhxmOtY7c01yVY+dCkP9wgx6Dv+NYPfRWlVqSXBUqvhnm1pfEqDK2+?=
 =?us-ascii?Q?K0ZhXQYBDd9tMW9UM7/rbA0QaSuTIW63QGqiMDr/rFZ8H7ScH39FKVb23gXP?=
 =?us-ascii?Q?GYuFngOGOZxtpn/0MTIyhFzJtxcg7Hj4BufcWzhqmJAzCaZHxesFoGkiy138?=
 =?us-ascii?Q?PysFhsqDZUWWmnisp6qPlTKso5BNa5kGCCsKhxOInNFYYWwUZU5vXj7avknm?=
 =?us-ascii?Q?gwk4mHh+LuK0TCQwioCQ15EFcVNZjgTckG4LG/uPXWYh4sraioJTT0MMw1fb?=
 =?us-ascii?Q?zauSd29FWVcAyyhedimGi2uEDSqiELeWkGCCw0Nwd3B8pO2+qdTeL9/PQKXe?=
 =?us-ascii?Q?VjoLGtztlmJOemc7n4nQNqzAeh1TD/z+Uwc/WqVPvdE0MJfLBGMBJM3zd+iG?=
 =?us-ascii?Q?mjFm5yDRc39Czly/uIj5q+q3EcSKtHBaaeCuIta4cfU6QS5BPBLiTmwMgSrV?=
 =?us-ascii?Q?xmbXCSZI4gPxwBXVZkoV0/RSpJ4AGufli5vyt2HwijzvTn8hGI44gAS3zmVt?=
 =?us-ascii?Q?aETZrFDLBVWS87W+qGM7bMo1nCboE7436o2zXlPp/6p8yOs6PH7Wz0xrkZ/X?=
 =?us-ascii?Q?gB6oXfiO/fTrDHb3/8txZugZCwxBQRjo5z8+a4EL97NvxHF3s6fGyb00I5qR?=
 =?us-ascii?Q?9t9cNv+xbtBj+mdh/9FdItlJLxnTe23K3NKKJJa3LLCC09nb5X8R5MOk1BVM?=
 =?us-ascii?Q?9gPcBK+XPrhNiW9NUtrdlr8aoC4n2L5oh8MMjIDReN5x+hkOFYSkjSY2rfma?=
 =?us-ascii?Q?VoMCCMlXC3uvDPRRJzYP9CFQ/BUeL1/tCo/Gr9ZxgnVYEXFuU7qzINC08pXs?=
 =?us-ascii?Q?1VxGU4lsWMHobBo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f09ec9f-8d5f-41b3-c5d9-08daa6d638c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 13:33:43.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8yyTSxzlGJEC10uqz/M3Ff9t5yvg58iA8okp7lw2+OlJlTg4yV+vIcVr5hv8T6mjQ02nkmL0kH3joA0Q3wieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050085
X-Proofpoint-GUID: Wlo5glAadIyNd10sgbwK4WiJwW_HvlzS
X-Proofpoint-ORIG-GUID: Wlo5glAadIyNd10sgbwK4WiJwW_HvlzS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Oct 5, 2022, at 6:06 AM, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> On Tue, 2022-10-04 at 10:39 +1100, NeilBrown wrote:
>> On Fri, 30 Sep 2022, Jeff Layton wrote:
>>>=20
>>> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
>>> index a5b71526cee0..9168bc657378 100644
>>> --- a/fs/nfsd/nfsfh.c
>>> +++ b/fs/nfsd/nfsfh.c
>>> @@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>>> 		stat.mtime =3D inode->i_mtime;
>>> 		stat.ctime =3D inode->i_ctime;
>>> 		stat.size  =3D inode->i_size;
>>> +		if (v4 && IS_I_VERSION(inode)) {
>>> +			stat.version =3D inode_query_iversion(inode);
>>> +			stat.result_mask |=3D STATX_VERSION;
>>> +		}
>>=20
>> This is increasingly ugly.  I wonder if it is justified at all...
>>=20
>=20
> I'm fine with dropping that. So if the getattrs fail, we should just not
> offer up pre/post attrs?

That sounds good to me.


--
Chuck Lever



