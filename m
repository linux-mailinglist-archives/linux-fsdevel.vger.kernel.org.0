Return-Path: <linux-fsdevel+bounces-7687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD6829612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530EC282250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BC3F8CE;
	Wed, 10 Jan 2024 09:16:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C83E49A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35ff23275b8so36584855ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 01:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878183; x=1705482983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynpI/nM/IJiO6ypbSyXoBl4LhSpd0dJb4e9X6vsrg/k=;
        b=iNJxZPsSzgrQ1H3XzzXJ5wo7SB61ibQfDLAD6CzcNCLSqUHWlGQTxGjXyWTytozdso
         C+qHkQ+wptYBAdvykv7rcB1RNCDZmViIFK9VtU0873NLgH0cMfICu/I0Ka4kyY+mdY0P
         GGkcx1DYyOX0ZDRax7RCbtO5vORlFiMnH4gNAsw5j6Nne14I1ZzdHcYLsco0ahX9keeJ
         DoWLIFIAbAqb/dUb4jLSpBW1oeY2IpWI7E+renJHNP1WMLdhG7OC+h36EampuQDoFKGA
         5+O6fCQ5LE2hLOWiS4nTjt3gFVA/BSpAMqfF7AxlKB/y87aq3bBbOTYXs6Uwcpn6PB05
         06dA==
X-Gm-Message-State: AOJu0Ywh+veorjDmb5IshMtO5qi12DN+NdoAQPJzMRyfIS2GaWx4GSu+
	93gIhxw5ZyDrisjhAiokwt5Km9i4M6nL6zSyPz3UONRIKiSszP0=
X-Google-Smtp-Source: AGHT+IGrldcR2+iDKETgG1fYtIDVVqO9mnQp40kMuF9pA7fomkm6CUaFWxGguEbgCpoFpBDaE9LjINBBKXXKJUxnXYNNzrnN4oCX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd87:0:b0:35f:f01e:bb1d with SMTP id
 r7-20020a92cd87000000b0035ff01ebb1dmr92797ilb.5.1704878183041; Wed, 10 Jan
 2024 01:16:23 -0800 (PST)
Date: Wed, 10 Jan 2024 01:16:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c52a1060e93e284@google.com>
Subject: [syzbot] Monthly hfs report (Jan 2024)
From: syzbot <syzbot+list08bb612e89fa1025c02c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 11 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10188   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7848    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<3>  7484    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<4>  4989    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  2911    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  1715    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  867     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  734     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  679     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<10> 599     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

