Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A87A85F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjITN7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjITN7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:59:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D102119;
        Wed, 20 Sep 2023 06:58:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K9sh7K031087;
        Wed, 20 Sep 2023 13:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4mqUiXBysWSrAjbIn2bo72BSbBFc4mdnL3V0feLD1eU=;
 b=G0aV8HdTG/QFwxCGAKkuoFnI+8HZ9g0Y0HIgm7M6FNNTCWFNod8F0Pobl3EWAZNRR8CQ
 F1wLpmo8JfHeCjqevpNDSMOTDeOdtJIAW+ifm+9oBJrLnYNJfTBs6WuBuTuFZK+dkK3x
 hR2RSQpEa231UJasKCLnQ34Ppa58pHPuuVV4YNH4eEVtoEjts3IueqA0sOClCevwRiCH
 fud9MB/ERlliPtpes3gFE8FuBFKbgPOR6KPaRb1zudihmQ/BJdnPpmqqR1Htw5Csf+/+
 osaxy6CASJ0zWPiAUs8I8+iOylqjhu9haJK6c+5olHUE8gud+gmoXd/fsKkKqT0MzHSG Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352ydrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 13:57:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KCaVSi002078;
        Wed, 20 Sep 2023 13:57:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6vnpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 13:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmv6srboKPeoI8d0Hk7VrwirSj8R7LcPoxPUSpt8Kyzi1ASn2dLQbdunTOuXARay0LM9VVsg+AiI3x00cDj75VAcO7a/NkNOsnqQTQJLYKx0kJKJi3MMol0Vul1sf9k9LD3T39wbpzligWVziultPz79pJd1BPqh7yhF7dxVSY2aAQ0uK3wSetJ6OwXUzo8BFUk3GlmUvjke5tF1MCjIfv0BRB4fTLEhtBBOejNybGf7wqE8nC1k+TY70wBdd7Fi/MFoOO/UdrQwDKabj6uYw2HsJVYf7R312QLoR4gnrVAKXHHK7KSUgMhzoVzDjZlVj5Qwllm6Xr/5P4tiYcnkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mqUiXBysWSrAjbIn2bo72BSbBFc4mdnL3V0feLD1eU=;
 b=oMXtZqHpBolI1NVS/DDH8J4sHN/yqGVnTJ6xy1g3+r7om9vv8VX3soXkHWTgtebgbp80+4wBEdpBHYbLC/53u/WaO/ECE4kir0bZ/lykK1nAxRyH4qTnUsT5vKQNwHIhOvyLZzIUDk2VtlIWTIkgD5SBvPsW2eq63UAAev3e5Nt0Pcoo7ESNI0T1btvxRsbvkW2LSbje7jnEB+3rjofaloHBY67HeVSxL5rsGGzp9Q9L7VscB2XG/DFVJEmFuxnyzreV55msWWOMRT8yMAi+v2Sf28zDCxqR8Kps//rKLiB+Vg0/mTt0dyFDbAH6uIaKmrqncshdGyMFWB8mIVYRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqUiXBysWSrAjbIn2bo72BSbBFc4mdnL3V0feLD1eU=;
 b=gCQ82UaU0/eGe9/NfLz5dggdxq0JsBg7dJKN5lFBQ23XsyTkQ3OBirVbjOwq2f+6JnyFflvipA7t5nVgyc8nUgrTCudsBSbxuVBDqKVfzLDUrxHlIF1moQHNJXAQ3FWVTGCidBCBSHbJFyZGcQFIUrOXw3yyqZnjoKkhB5N89cM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7138.namprd10.prod.outlook.com (2603:10b6:610:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 13:57:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:57:20 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>,
        "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "coda@cs.cmu.edu" <coda@cs.cmu.edu>,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bo b Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
        "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Thread-Topic: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Thread-Index: AQHZ6sjv7JGmOLGi70WrXuPbQ19SCbAh/K6AgAAH9ICAAFNcAoABDvAAgAAa1ICAAAT4AIAAFJaAgAAjz4A=
Date:   Wed, 20 Sep 2023 13:57:20 +0000
Message-ID: <57C103E1-1AD2-4D86-926C-481BC6BDB191@oracle.com>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
 <20230920-raser-teehaus-029cafd5a6e4@brauner>
In-Reply-To: <20230920-raser-teehaus-029cafd5a6e4@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7138:EE_
x-ms-office365-filtering-correlation-id: 191ae751-f64b-42ff-3af0-08dbb9e1820d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6CeqI7yo9SlUW+tP4Cyx202GQADlRpz/v2zpxanUP9lgwpFB7WAy/O4gY/2Cddv/evXdchj+76dLtD6r6HntM7hyS4DE3InHcM/EsBfN0aDrsDFeIWvagF+3dYYnYq/FRzwXbz2LwALO47wEoK7L/6Nb5EVAwxY27W/VnYv1oZgwzGgPELL1liNzvIOhG+u6lyz+cKD1c+J1OICsyrOYPFomMuDk0SWqOmEzeErQUBJDX0j4Ozbo99QdhwzfU/6W+QZlOFXJ48Gh4vw0gOrbdIKLCWAROjtXw+nFwqvy7vhgAY02pSrdF4nrfDvlbSSg624QCMVriqwrr+hFJPXPZtqaubxGup51rqs68lnzPIeE//LVhEYPvbMYAqQ8JEgTYCSCFKwL2FTJyjh3M7MV1WPQGVFlw5XNBqJ7w6ZIygIVH5Um0+ru9waKLqpoN6WC5fIN85HgIKL7+s3lyESZFllwYyueVyI/nsZLcFOZcscJTjFvp6SLij8H6SxX7YEEl83todW4EI8HhbMCzXY+Sn2vqMR+c6OOX3U9wsO9YjjaIjF8U+iCvE0xkZrOEgCnz7O2HGJjWaX9tXvvSdPJZk3cIwB2NF8L6699qXFC7HJAzc4Bi6AagJQaxnvpDKd0Vlb/iCcrdngrH+t5vk5GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6506007)(53546011)(6486002)(6512007)(478600001)(83380400001)(26005)(2616005)(2906002)(7336002)(7366002)(4326008)(7406005)(7416002)(76116006)(54906003)(66446008)(64756008)(66556008)(6916009)(66946007)(66476007)(316002)(8676002)(91956017)(5660300002)(8936002)(41300700001)(71200400001)(86362001)(36756003)(33656002)(38100700002)(38070700005)(122000001)(66899024)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?60avSYq2fwYZ7dG+1aS5kmkpnkeKwXxhURWlbIIn/9mqvpayoyRHzaeB03lD?=
 =?us-ascii?Q?m6okOLiMlCh9sI8WMzFkqvGmgadQgYjVrT+eJl2VMyvQ5dxSl/i3sJw98xtj?=
 =?us-ascii?Q?nhc6XTHVFsvw4D1+wRbCQiHhR7RNjr5PhQKCB60jBg/r8GFtqD1jOwJakOYU?=
 =?us-ascii?Q?2g3QxIxFA+gPe6vr9rsLakM2JahY8oEe9PQCW0kWlfIhHXqy3nXYACOFa9kR?=
 =?us-ascii?Q?/cFfbNzc5BzL+4UFEXB0avbAvB5b6Oyyv0WNOPFF6w6WXZuyT8c65GlhjaLg?=
 =?us-ascii?Q?zjECrKxzQ5zjlR4VbETlkpYWWtyGWTnY0U96B6x6xFx2Rg0gVJCcEoHjDETV?=
 =?us-ascii?Q?Adg9VLh+PVhAI+G5Gezran6AOcaRTmOoixkyzTg0XKOcSg478Pmjc9vpDKpB?=
 =?us-ascii?Q?BvOhgj+/AdeoXdgWH9WrW79T/NyYJw+xaXN5Y4yj+mRXtgyd3EHsjafpHajq?=
 =?us-ascii?Q?K55UB4M4ViV9d5HUMC44iYtkC3I4R5vEW886jgOy0ftHI/gfWJZvlOxsO1SK?=
 =?us-ascii?Q?Ma4v0Ij+DrxvEDnVzJ2P+hyDZ9OXbY1/tfKDWef6fHt2l/VlFofoMXrqfg3A?=
 =?us-ascii?Q?klo9kn3dOpqJDmtYheUOnMGEynSkyQNWc8YFWGj30bxSvJS/wnCx/6fYPfoS?=
 =?us-ascii?Q?zLyeRt+kGCydaJYyYr1qFY3OgmX6gip6lfiQfgO9S0+VZsOj8Zl7G4BKvieR?=
 =?us-ascii?Q?4JHQyFhKTNF/tEji9FctKf86eUL0zPAJ4G4JApyR0Hs+tIdlBlu94bCcUAXt?=
 =?us-ascii?Q?7Wwj9bc0jVfaCfqqfI1sQwnDnD9ie5Km8YJNkQpjQlY66idznjS8TAXV+Tiv?=
 =?us-ascii?Q?5nLDUfI0Ky8Tqa9PHW/J67K6SWFA2+tuQAjAx0VOTNraYyuJQRf6QeeEh1A2?=
 =?us-ascii?Q?XPZJBRp0iYpzwYxS8D2hUHLtmJUr/pM6kOnLY/ajmkW42xRmyjxTNG/6gnxt?=
 =?us-ascii?Q?gkyGzr4vwReE2M/JBkVXSJSIBzVyXDbF+kJBge4Mdo8qDifOkghMD0zRyORS?=
 =?us-ascii?Q?s34n9u4QVKDVJS5ZbaqwsH3Nj1CA2HiQa1VHq16mJoDx/MtfOFBASwccICMy?=
 =?us-ascii?Q?1BU1R19qOqxdLRhAtzvSdm7tH8HEfC3Ho/rCFyXJh6C+g2hT9ZL3QgFgHdHV?=
 =?us-ascii?Q?ZQtYJwjy3vGCHTAmXphXL8G16+cvsHTaUm+lIF2aYFHo4PVNz0DXK7DgU0wu?=
 =?us-ascii?Q?VnTw2PZnWBPgU0kJ+NeDmE8QunGs9n75aUYAAXyZLI7etqXhqWrLoEqEEije?=
 =?us-ascii?Q?opCXk5INovHsb2pf+E1elAL7GUeukuL7gDd/Y7yWbsmwVA9dKRE36oMmmDXC?=
 =?us-ascii?Q?PibH9bv1i7paXH9y4io5zZQrwmpO20J2jCXCseWuWMAYhxS9wH39aw/H0xn+?=
 =?us-ascii?Q?EYOKTz66TkMyXPtMAV62d2qYVeGidTt6lBtmb81FaZ/ek5a4BIx2kpF8baTX?=
 =?us-ascii?Q?EbKi0hzUGO/gmZbXiPLUkrEyY7vxm7Ce03xBC5/9eepbG0Gab1gP0N2GO/sY?=
 =?us-ascii?Q?PFPBAYOekJgeGIwFKma63umXwV344zFQO/imsOFZegRXsnzbY/xaD97je5aL?=
 =?us-ascii?Q?owZgvydQQEuuMr+bIXR9KfjZdL6hW0MG0oxtQbBEwDfS3PPz9tsLLBJu8UbK?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C645C8D819FE4428F17CF964FD859C3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Yv+C8y2Cckn475Yhj3ETSOj/qvDGxFNXhQvLUEYI0V+DCO8O6kmxB7c/mBjM?=
 =?us-ascii?Q?BPh5KhfZquc5QrPv05/vstysdpT/N/uimg9vUjb4Ez/VgRVuasyv0azVgN9c?=
 =?us-ascii?Q?M9oBsmXFage8g4x5Qyve6od0sROFXOU1cHq6rlXjESrm87rQDKp6aTmTowms?=
 =?us-ascii?Q?VJXLEZ4mBLJmlXdpQ98iEovnGTNVfynA6WBO25aV0YLRvZ1rEjT6k+3SnKE/?=
 =?us-ascii?Q?RuNgnPNt680fSnTwQ8++XcGGg5QXrEhoo+fILdwFoGm5BcTm4eHHRb5TwK25?=
 =?us-ascii?Q?za12DNzOZCgb9dvumdLsHkHiMSFVDlVcW/Omvppqw2pOWf1llROwuDJZfLd/?=
 =?us-ascii?Q?96PmPU/4jR3Dt2bBWwXj1N5psornBSdE+1qJOILqgHczZGKqHhrNynwbrc1z?=
 =?us-ascii?Q?Tau82jq5BkuSPX4SSbSfO3FcxbqMwtl3A0M3S3SsQxUG4twIjvWl3IhMT+8j?=
 =?us-ascii?Q?/JzUAxfLLFdzef9b8kqHurXwQmKnfiRDgOAfWnEpbkK90ArXBTMkyMNrdHtI?=
 =?us-ascii?Q?VR0N+x3Gkg/gi/fKTkySZv76ZiD8DT7rpLezSKR2St2kcmc71Wr7J3eZbaj/?=
 =?us-ascii?Q?K8QWmPsGDZizADjgeULPPp5SY6cOZoGyA7J763zVdlGQKuPUkMgXzzPTuxpa?=
 =?us-ascii?Q?mokXFuvvxVJPtKup8+EfIztqgIdcevWw2NCprXXW7TTv7xXgr2awY6dTV1R0?=
 =?us-ascii?Q?j50/99NtaCSfjcWWWA7yFJSFmeq7Pm2ckYvdjgmpYXh3kiXrY4p05Wotf+8z?=
 =?us-ascii?Q?nBpiBaoXReiCOZKMuGnn8Ycsxp5VhJrXUjYZhy91NCUewZgxT0aLR/iFMyfT?=
 =?us-ascii?Q?HplapJyuhaaxfuNF/l53lHdbduOAdRfC/JXygg0IMzdmsEbuEESw6gh1RIVK?=
 =?us-ascii?Q?mnV7NL9Syh6bZGMGePdsfoBNZEO3bw2SAuLWuMh5329AaOXMT5WNsfn4bKHi?=
 =?us-ascii?Q?kUtc0ZYCk/TfWL8HfV4AcGU9w2fhYShyOshvQVjwurStWUpHeOH43rt6DECI?=
 =?us-ascii?Q?HWYP8BKtGuLXNMs6SG+sG/q7FvjmS5DfDNLl803D2sKr9AiJ4PZET0a3hvHQ?=
 =?us-ascii?Q?UN23kTV1H+doMdAxA1W1/ioecQrzkU5IAaedPDWI4DcANn8fiPL+Y7SrfBjK?=
 =?us-ascii?Q?r0NkuytYSPGyM+we3fEmGRztOfeqmABVbHD3dHD3PBaSyfsT7rN4/jfOisJr?=
 =?us-ascii?Q?oBdYR8EhKc8Hi0jWujrZd/PxkrqWFdfsBUgDcmpEZ44tLKpOJjiAKfojLFi2?=
 =?us-ascii?Q?hEOsIAH0FebymDtAXdukCDQN/icZNyomqxCFZ5aM/jrgCuT/U+JDT9WmjJTs?=
 =?us-ascii?Q?Yv89tpeBaMD5irl2PUR5Jzr1wqCQF1X1GxV0cD+3pfoCWEMJ5IXPxm8wY6U7?=
 =?us-ascii?Q?C6mEhW3AjLSoGsIA81DD1mgwbi81CPepT/YUjnz54unCwE7YEPZt1Op6qm82?=
 =?us-ascii?Q?dnw2OiLmL/UfVaPKUHfMMk2oXc6GQxdjs6MOj8l3vVUVaEPxIHTq0KYjKwt1?=
 =?us-ascii?Q?r9y2PQq6FYOQgeyOo2XAoQb9xF2S5KS4AOE8XwTs87tw+mKF19eMqAKxZyOy?=
 =?us-ascii?Q?LhJuwZxoV23/h7gpLFZKZV3gQnt4vuoakBPmF+WKFxYoB2tGwFYeAtsz5zSU?=
 =?us-ascii?Q?PvGpH4eRroTf5Vg+pQ3hii3oFqdOO69NoZQalEpIp6mh49yh1iHd0zVi35d6?=
 =?us-ascii?Q?TnvRRMUWMxvMCnmc5SGvJLik37FN733cFReh4SEpSBuj4THIs1u7fLgp9Kou?=
 =?us-ascii?Q?nxS5K3P0+CAFU7uBK8o90l8B/LUB0Ni12NNW42IMp67jjCSf0LFqdpZrWJVt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: eALm2uZ6q9q42Gpz++pvkm9VnoRRQidt6NcqbKRRv9XVLJfcDI3EcOs4Ioq2y1MnVSXGaW4yHyF/V7REFmozN781hfK6JtvFf+DeGIQ6N7JBUxm7+O2QMiIJ20unktkwB5C4e3ZMy4M/7iNrbYGNFm18FCJevqsWxzMThTTUUxibS0BPi65u0HJy29o5bg+hgqcWpLHMx4rm3QmkrlM6pXDhROJNYQSzl+2Ehzwjz16uCjyOeh4LbvAYrm7ms4uwdU2ng6jRxEFfctcxo3n/1Op3hFNHl8mU+XzDxmEsKmlqPbj681rD3KLkv4GHwlEJQPKBQjf0ISnEN85YTEuMoNcwSvODDP6OTqdREFapCj8KObTzMbbw8GybFuXkKXJtU72XEvV4C2GysNtDxXK2ztoQ+SP7ZnyqRDlSMs685fK+cMM/K1HkRWFMqaZxRvZQwBML7r8VXjOt0sbiTQA8l/XakPofWMxUIFZjsqrmiIg88BA/f5U9xoJcW815l4g7t1Z9iGMjGOGDekzWRLJW7xS3511wBTFhwVgaQ8aVBgZYkkD0nq+BJZLYCNg3xR3kK2bLxZs09/tbOJ8kTwcgdxR9w+hafek1BSnSKD7bkaXKQ5ezjD2rq7uUm24Xm+5ASD/DdG+OPhEnVg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191ae751-f64b-42ff-3af0-08dbb9e1820d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:57:20.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gt2gy5hUzNI9y2DFfbA5T/SEsjfbKDQdcFZztpnR1XSkHUXgHRhK7SPca5XNr2tRzii70htTIcf7Ehl7tM74yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309200114
X-Proofpoint-ORIG-GUID: 1sVYCLy-lrnGMYMM408XV_XkB2BJbt1t
X-Proofpoint-GUID: 1sVYCLy-lrnGMYMM408XV_XkB2BJbt1t
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 20, 2023, at 7:48 AM, Christian Brauner <brauner@kernel.org> wrote=
:
>=20
>>>> While we initially thought we can do this unconditionally it turns out
>>>> that this might break existing workloads that rely on timestamps in ve=
ry
>>>> specific ways and we always knew this was a possibility. Move
>>>> multi-grain timestamps behind a vfs mount option.
>>>=20
>>> Surely this is a safe choice as it moves the responsibility to the sysa=
dmin
>>> and the cases where finegrained timestamps are required. But I kind of
>>> wonder how is the sysadmin going to decide whether mgtime is safe for h=
is
>>> system or not? Because the possible breakage needn't be obvious at the
>>> first sight...
>>>=20
>>=20
>> That's the main reason I really didn't want to go with a mount option.
>> Documenting that may be difficult. While there is some pessimism around
>> it, I may still take a stab at just advancing the coarse clock whenever
>> we fetch a fine-grained timestamp. It'd be nice to remove this option in
>> the future if that turns out to be feasible.
>>=20
>>> If I were a sysadmin, I'd rather opt for something like
>>> finegrained timestamps + lazytime (if I needed the finegrained timestam=
ps
>>> functionality). That should avoid the IO overhead of finegrained timest=
amps
>>> as well and I'd know I can have problems with timestamps only after a
>>> system crash.
>>=20
>>> I've just got another idea how we could solve the problem: Couldn't we
>>> always just report coarsegrained timestamp to userspace and provide acc=
ess
>>> to finegrained value only to NFS which should know what it's doing?
>>>=20
>>=20
>> I think that'd be hard. First of all, where would we store the second
>> timestamp? We can't just truncate the fine-grained ones to come up with
>> a coarse-grained one. It might also be confusing having nfsd and local
>> filesystems present different attributes.
>=20
> As far as I can tell we have two options. The first one is to make this
> into a mount option which I really think isn't a big deal and lets us
> avoid this whole problem while allowing filesytems exposed via NFS to
> make use of this feature for change tracking.

A mount option isn't hard to implement, but I think it would be a
mistake.

As Jan pointed out, the two alternative compromises are often very
difficult to choose between. Tossing this decision to administrators
doesn't seem like a responsible way to handle a question that might
result in, at the least, unexpected behavior, and at worst, data
corruption.

Plus, on Linux, often times files are accessed locally on NFS servers
as well as remotely -- how does the server's administrator pick the
correct setting in that case?


> The second option is that we turn off fine-grained finestamps for v6.6
> and you get to explore other options.

You could put it behind an EXPERIMENTAL Kconfig option so that the
code stays in and can be used by the brave or foolish while it is
still being refined.


> It isn't a big deal regressions like this were always to be expected but
> v6.6 needs to stabilize so anything that requires more significant work
> is not an option.


--
Chuck Lever


