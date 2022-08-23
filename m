Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8859CFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 06:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiHWEUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 00:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbiHWEUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D945E316
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661228402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tsW9Qubr1PtTTYMn36tQKaje9CJLhaJWoU401/ORweU=;
        b=dYAgj6bb4KZgebuRIE8r3PWwjFEFgkb0FpPlt+HvEGY+BKaQ3mrWS5jfT5uwp4pYy5tEsr
        L1PGH04WYF3a8HwOYiHHeWvvloOpu8dKzc3FBzlimtA3kJZ6HyVLMOLdrTU2pTNOoIGzI4
        3MuRPWogdq7cI6pjWxP0TXO/WbiWnj8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-9LOvlMcpPxWhED3ij8cLfA-1; Tue, 23 Aug 2022 00:16:59 -0400
X-MC-Unique: 9LOvlMcpPxWhED3ij8cLfA-1
Received: by mail-pj1-f69.google.com with SMTP id rj3-20020a17090b3e8300b001fae0be4dc4so7379544pjb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 21:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=tsW9Qubr1PtTTYMn36tQKaje9CJLhaJWoU401/ORweU=;
        b=IUM+BttwOiiIUgs+kEEf7uimDsL7jpnvfMvHO8pI7kt8jAqX6Gl6yaX2PvUaoBo9Pv
         fK9IwlxFdcke4MSj+E/P+VxMuo7T0lJIZIpASSQriXhjXYZyZuzDqRSSGge8G4vDyERD
         2iTxZTt66EA7e33CKYhH9EQuXTJeYJUHCF2f+glKFVQMmlwUE6Njw8w5ZnsViZiDEE5Y
         ESLV0Q/VfAELpi7kgy+SE1k1Ol7f51JqIsALy64fKz/WsJ9akTu7F7NwRO3RW+V+iXSo
         SB6kgkAlQW7Xb6fXl0+snPDEWh6bI3Es5TAwRKyKgRQTho6RH2GeP/+ghPATQLMA3cQz
         St6Q==
X-Gm-Message-State: ACgBeo04jjaY3YFeR9n2SMK+Djx+fUkLi2VpFMvPihRip6fRU2nc6NCT
        F6D0OWi6EV2w5gbCY/6TCaT8uBUYirSdo2qM544X5it0qhQjqgOCLP3dP95wh6LwYGNZ9nDZ9Ka
        PybtIiYKDRCqntGRPd0staHVCmTI9uYSnq+m8JYHMcg==
X-Received: by 2002:a63:ea11:0:b0:41d:9296:21e6 with SMTP id c17-20020a63ea11000000b0041d929621e6mr18760871pgi.603.1661228217952;
        Mon, 22 Aug 2022 21:16:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/9w3ZXhaTOMyPo/2Z3zgJaSIgiqLF2jVltGdJ37OsWg5Ko7C5K6lX76JNRmYw0KOVAjedKRxplXY43zF1eDg=
X-Received: by 2002:a63:ea11:0:b0:41d:9296:21e6 with SMTP id
 c17-20020a63ea11000000b0041d929621e6mr18760859pgi.603.1661228217682; Mon, 22
 Aug 2022 21:16:57 -0700 (PDT)
MIME-Version: 1.0
From:   Boyang Xue <bxue@redhat.com>
Date:   Tue, 23 Aug 2022 12:16:46 +0800
Message-ID: <CAHLe9YZvOcbimNsaYa=jk27uUR1jgVDtXXztLEa0AVnqveOoyQ@mail.gmail.com>
Subject: [bug report] disk quota exceed after multiple write/delete loops
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000ce7bc605e6e0d5f3"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000ce7bc605e6e0d5f3
Content-Type: text/plain; charset="UTF-8"

On the latest kernel 6.0.0-0.rc2, I find the user quota limit in an
ext4 mount is unstable, that after several successful "write file then
delete" loops, it will finally fail with "Disk quota exceeded". This
bug can be reproduced on at least kernel-6.0.0-0.rc2 and
kernel-5.14.0-*, but can't be reproduced on kernel-4.18.0 based RHEL8
kernel.

Reproducer (can also be found as the attachment):
```
#!/bin/bash

# setup
groupadd -f quota_test
useradd -g quota_test quota_test_user1
dd if=/dev/null of=ext4_5G.img bs=1G seek=5
lo_dev=$(losetup -f --show ext4_5G.img)
mkdir /mntpt
mkfs.ext4 -F ext4_5G.img
mount -o usrquota ext4_5G.img /mntpt
chmod 777 /mntpt
quotacheck -u /mntpt
setquota -u quota_test_user1 200000 300000 2000 3000 /mntpt
quotaon -u /mntpt

# test
for i in $(seq 1 100); do
    echo "*** Run#$((i++)) ***"
    echo "--- Quota before writing file ---"; quota -uv
quota_test_user1; echo "--- ---"
    su - quota_test_user1 -c "dd if=/dev/zero of=/mntpt/test_300m
bs=1024 count=300000" || break_flag=1
    echo "--- Quota after writing file ---"; quota -uv
quota_test_user1; echo "--- ---"
    rm -f /mntpt/test_300m
    sleep 10s # in case slow deletion
    echo "--- Quota after deleting file ---"; quota -uv
quota_test_user1; echo "--- ---"
    [[ $break_flag -eq 1 ]] && break
done

# cleanup
umount /mntpt
losetup -D
rm -rf ext4_5G.img /mntpt
userdel -r quota_test_user1
groupdel quota_test
```

Run log on kernel-6.0.0-0.rc2
```
(...skip successful Run#[1-2]...)
*** Run#3 ***
--- Quota before writing file ---
Disk quotas for user quota_test_user1 (uid 1003):
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
     /dev/loop0       0  200000  300000               0    2000    3000
--- ---
dd: error writing '/mntpt/test_300m': Disk quota exceeded
299997+0 records in
299996+0 records out
307195904 bytes (307 MB, 293 MiB) copied, 1.44836 s, 212 MB/s
--- Quota after writing file ---
Disk quotas for user quota_test_user1 (uid 1003):
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
     /dev/loop0  300000* 200000  300000   7days       1    2000    3000
--- ---
--- Quota after deleting file ---
Disk quotas for user quota_test_user1 (uid 1003):
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
     /dev/loop0       0  200000  300000               0    2000    3000
--- ---
```

The kernel in test can be found at
https://koji.fedoraproject.org/koji/buildinfo?buildID=2050107

--000000000000ce7bc605e6e0d5f3
Content-Type: application/x-sh; name="test_quota_v01.sh"
Content-Disposition: attachment; filename="test_quota_v01.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l75o5cw00>
X-Attachment-Id: f_l75o5cw00

IyEvYmluL2Jhc2gKCiMgc2V0dXAKZ3JvdXBhZGQgLWYgcXVvdGFfdGVzdAp1c2VyYWRkIC1nIHF1
b3RhX3Rlc3QgcXVvdGFfdGVzdF91c2VyMQpkZCBpZj0vZGV2L251bGwgb2Y9ZXh0NF81Ry5pbWcg
YnM9MUcgc2Vlaz01CmxvX2Rldj0kKGxvc2V0dXAgLWYgLS1zaG93IGV4dDRfNUcuaW1nKQpta2Rp
ciAvbW50cHQKbWtmcy5leHQ0IC1GIGV4dDRfNUcuaW1nCm1vdW50IC1vIHVzcnF1b3RhIGV4dDRf
NUcuaW1nIC9tbnRwdApjaG1vZCA3NzcgL21udHB0CnF1b3RhY2hlY2sgLXUgL21udHB0CnNldHF1
b3RhIC11IHF1b3RhX3Rlc3RfdXNlcjEgMjAwMDAwIDMwMDAwMCAyMDAwIDMwMDAgL21udHB0CnF1
b3Rhb24gLXUgL21udHB0CgojIHRlc3QKZm9yIGkgaW4gJChzZXEgMSAxMDApOyBkbwogICAgICAg
IGVjaG8gIioqKiBSdW4jJCgoaSsrKSkgKioqIgoJZWNobyAiLS0tIFF1b3RhIGJlZm9yZSB3cml0
aW5nIGZpbGUgLS0tIjsgcXVvdGEgLXV2IHF1b3RhX3Rlc3RfdXNlcjE7IGVjaG8gIi0tLSAtLS0i
CglzdSAtIHF1b3RhX3Rlc3RfdXNlcjEgLWMgImRkIGlmPS9kZXYvemVybyBvZj0vbW50cHQvdGVz
dF8zMDBtIGJzPTEwMjQgY291bnQ9MzAwMDAwIiB8fCBicmVha19mbGFnPTEKCWVjaG8gIi0tLSBR
dW90YSBhZnRlciB3cml0aW5nIGZpbGUgLS0tIjsgcXVvdGEgLXV2IHF1b3RhX3Rlc3RfdXNlcjE7
IGVjaG8gIi0tLSAtLS0iCglybSAtZiAvbW50cHQvdGVzdF8zMDBtCglzbGVlcCAxMHMgIyBpbiBj
YXNlIHNsb3cgZGVsZXRpb24KCWVjaG8gIi0tLSBRdW90YSBhZnRlciBkZWxldGluZyBmaWxlIC0t
LSI7IHF1b3RhIC11diBxdW90YV90ZXN0X3VzZXIxOyBlY2hvICItLS0gLS0tIgoJW1sgJGJyZWFr
X2ZsYWcgLWVxIDEgXV0gJiYgYnJlYWsKZG9uZQoKIyBjbGVhbnVwCnVtb3VudCAvbW50cHQKbG9z
ZXR1cCAtRApybSAtcmYgZXh0NF81Ry5pbWcgL21udHB0CnVzZXJkZWwgLXIgcXVvdGFfdGVzdF91
c2VyMQpncm91cGRlbCBxdW90YV90ZXN0Cg==
--000000000000ce7bc605e6e0d5f3--

