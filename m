Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CAD35C5FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhDLMQT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 08:16:19 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:59198 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237283AbhDLMQS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:16:18 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 08:16:16 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.43/8.16.0.43) with SMTP id 13CBuj4R036297;
        Mon, 12 Apr 2021 15:05:00 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 37vmqsr2ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 15:05:00 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 15:04:59 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.012; Mon, 12 Apr 2021 15:04:59 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>
CC:     "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "alban@kinvolk.io" <alban@kinvolk.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "hch@lst.de" <hch@lst.de>,
        "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lennart@poettering.net" <lennart@poettering.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mpatel@redhat.com" <mpatel@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        "smbarber@chromium.org" <smbarber@chromium.org>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "tkjos@google.com" <tkjos@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "tycho@tycho.ws" <tycho@tycho.ws>, "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 24/40] fs: make helpers idmap mount aware
Thread-Topic: [PATCH v6 24/40] fs: make helpers idmap mount aware
Thread-Index: AQHXL5QPJZ+OaKJz8USD3Dodtq0P1w==
Date:   Mon, 12 Apr 2021 12:04:59 +0000
Message-ID: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.145.212.130]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BA514E4FAABFD8498C8B1419EB26396B@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-GUID: Vd5127wVnEcv9vrUnKYvowNFSa7J_xlE
X-Proofpoint-ORIG-GUID: Vd5127wVnEcv9vrUnKYvowNFSa7J_xlE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_09:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120082
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I noticed this patch got merged into mainline and looking through the HFS+ changes, I noticed something that struck me as odd.  I am not familiar with this patch set so perhaps it is the intention but I wanted to ask you because it just seems strange thing to do.

So you are adding a new argument of "struct user_namespace *mnt_userns" to lots of functions but then inside the functions when they call another function you often make that use "&init_user_ns" instead of the passed in "mnt_userns" which kind of defeats the point of having the new "mnt_userns" argument altogether, doesn't it?

Example after this chunk:

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 642e067d8fe8..7a937de9b2ad 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -241,7 +241,8 @@ static int hfsplus_file_release(struct inode *inode, struct file *file)
        return 0;
 }

-static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
+static int hfsplus_setattr(struct user_namespace *mnt_userns,
+                    struct dentry *dentry, struct iattr *attr)
 {
        struct inode *inode = d_inode(dentry);
        int error;

The code now looks like this:

static int hfsplus_setattr(struct user_namespace *mnt_userns,
                           struct dentry *dentry, struct iattr *attr)
{
        struct inode *inode = d_inode(dentry);
        int error;

        error = setattr_prepare(&init_user_ns, dentry, attr);
        if (error)
                return error;
[...]
        setattr_copy(&init_user_ns, inode, attr);
        mark_inode_dirty(inode);

        return 0;
}

Shouldn't that be using mnt_userns instead of &init_user_ns both for the setattr_prepare() and setattr_copy() calls?

Please note this is just one example - it seems the kernel is now littered with such examples in current mainline and I don't mean just HFS+ - this is now all over the place...

Best regards,

	Anton
-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

