Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C501541C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBFKWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:22:10 -0500
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:50686 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728263AbgBFKWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:22:10 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20200206095047.CWDA19078.re-prd-fep-048.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 6 Feb 2020 09:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580982647; 
        bh=nJvjjG5ZDi3yonVzta7KkxJW26NrokZBWhkG7lv2354=;
        h=Message-ID:Subject:From:To:Cc:Date:MIME-Version;
        b=j9v3gOw5q1P2B6UxmN1YNg/zpzEUvPiwT8l0i/RTl13HkyRPptNhgUbTmbQdmKF8qt2XOVqp2XHzrl7Bpe5/x29+6IXqqi4HC0VHUKBjZmMtewLSsgsI6qc3zhmEMABDW5ddA6TTH0alCo0Gc8QrhvNmQnXVy+3U5EVfVDrzyntnPoArIYVzmS6kwbMxlvIA7Aq4AXyNnJFl9wRv3d8PPwaFod51J+9khWR2sRKN8+wfT/0sbltYgryl5ogz/GVIOtU9BxOxW8Zgg/baZ8A4O1IX2L3FlDvxc67TyHrRuUPG9pu9ISIvGQ9vIxvsiFXrYctQ7oc4Iw3koP8LpenTpA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.31]
X-OWM-Source-IP: 86.134.5.31 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrheefgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggesmhdtreertderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedrhedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrhedrfedupdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghp
        thhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeovhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.31) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A195F003B18F1; Thu, 6 Feb 2020 09:50:47 +0000
Message-ID: <c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com>
Subject: Test to trace kernel bug in fsconfig(2) with btrfs
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     selinux@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, sds@tycho.nsa.gov, paul@paul-moore.com,
        omosnace@redhat.com
Date:   Thu, 06 Feb 2020 09:50:46 +0000
Content-Type: multipart/mixed; boundary="=-kuWbBwHyLOAMAixjfzuu"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-kuWbBwHyLOAMAixjfzuu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've attached a test program 'fsmount.c'. This can be used along with
the test script below to show a kernel bug when calling fsconfig(2)
with security options on a btrfs filesystem.

This problem only occurs using fsconfig(2) when attempting to add
security options. Setting a native btrfs option (e.g. flushoncommit)
works.

Copy the statements below into test.sh and run with the fs name. Other
fs will work such as ext4, xfs. Only btrfs will fail.

#!/bin/sh
fs_name=$1

mkdir -p /mnt/selinux-testsuite
dd if=/dev/zero of=./fstest bs=4096 count=27904
dev=`losetup -f`
losetup $dev ./fstest
mkfs.$fs_name $dev
/usr/bin/systemctl stop udisks2 # Stops crap appearing in journal log
# mount(2) works:
#mount -t $fs_name -o "rootcontext=system_u:object_r:unconfined_t:s0"
$dev /mnt/selinux-testsuite
# This native btrfs "flushoncommit" option will work with fsconfig(2):
#./fsmount $fs_name $dev  /mnt/selinux-testsuite "flushoncommit"
# This will not:
./fsmount $fs_name $dev  /mnt/selinux-testsuite
"rootcontext=system_u:object_r:unconfined_t:s0"
# rootcontext fails with journal entry: SELinux: mount invalid.
#    Same superblock, different security settings for (dev loop0, type
btrfs)
umount /mnt/selinux-testsuite
losetup -d $dev
/usr/bin/systemctl start udisks2
rm -f ./fstest


--=-kuWbBwHyLOAMAixjfzuu
Content-Disposition: attachment; filename="fsmount.c"
Content-Type: text/x-csrc; name="fsmount.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

LyogY2MgZnNtb3VudC5jIC1vIGZzbW91bnQgLVdhbGwgKi8KI2luY2x1ZGUgPHN0ZGlvLmg+CiNp
bmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN5cy9wcmN0
bC5oPgojaW5jbHVkZSA8bGludXgvbW91bnQuaD4KI2luY2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPgoK
aW50IGZzb3Blbihjb25zdCBjaGFyICpmc19uYW1lLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCnsKCXJl
dHVybiBzeXNjYWxsKF9fTlJfZnNvcGVuLCBmc19uYW1lLCBmbGFncyk7Cn0KCmludCBmc2NvbmZp
ZyhpbnQgZnNmZCwgdW5zaWduZWQgaW50IGNtZCwgY29uc3QgY2hhciAqa2V5LAoJICAgICBjb25z
dCB2b2lkICp2YWwsIGludCBhdXgpCnsKCXJldHVybiBzeXNjYWxsKF9fTlJfZnNjb25maWcsIGZz
ZmQsIGNtZCwga2V5LCB2YWwsIGF1eCk7Cn0KCmludCBmc21vdW50KGludCBmc2ZkLCB1bnNpZ25l
ZCBpbnQgZmxhZ3MsIHVuc2lnbmVkIGludCBtc19mbGFncykKewoJcmV0dXJuIHN5c2NhbGwoX19O
Ul9mc21vdW50LCBmc2ZkLCBmbGFncywgbXNfZmxhZ3MpOwp9CgppbnQgbW92ZV9tb3VudChpbnQg
ZnJvbV9kZmQsIGNvbnN0IGNoYXIgKmZyb21fcGF0aG5hbWUsIGludCB0b19kZmQsCgkgICAgICAg
Y29uc3QgY2hhciAqdG9fcGF0aG5hbWUsIHVuc2lnbmVkIGludCBmbGFncykKewoJcmV0dXJuIHN5
c2NhbGwoX19OUl9tb3ZlX21vdW50LCBmcm9tX2RmZCwgZnJvbV9wYXRobmFtZSwKCQkgICAgICAg
dG9fZGZkLCB0b19wYXRobmFtZSwgZmxhZ3MpOwp9CgojZGVmaW5lIE1BWF9PUFMgMTAKaW50IGZz
Y29uZmlnX29wdHMoaW50IGZkLCBjaGFyICpzcmMsIGNoYXIgKm9wdHMpCnsKCWludCByZXQsIGks
IG1heF9lbnRyaWVzID0gMDsKCWludCBjbWRbTUFYX09QU107CgljaGFyICprZXlbTUFYX09QU10s
ICp2YWx1ZVtNQVhfT1BTXTsKCWNoYXIgKnNyY19zdHIgPSAic291cmNlIjsKCgljbWRbMF0gPSBG
U0NPTkZJR19TRVRfU1RSSU5HOwoJa2V5WzBdID0gc3JjX3N0cjsKCXZhbHVlWzBdID0gc3JjOwoK
CWZvciAoaSA9IDE7IGkgPCBNQVhfT1BTOyBpKyspIHsKCQl2YWx1ZVtpXSA9IHN0cnNlcCgmb3B0
cywgIiwiKTsKCQlpZiAoIXZhbHVlW2ldKSB7CgkJCW1heF9lbnRyaWVzID0gaSArIDE7CgkJCWJy
ZWFrOwoJCX0KCQljbWRbaV0gPSBGU0NPTkZJR19TRVRfU1RSSU5HOwoJfQoKCWZvciAoaSA9IDE7
IHZhbHVlW2ldICE9IE5VTEw7IGkrKykgewoJCWtleVtpXSA9IHN0cnNlcCgmdmFsdWVbaV0sICI9
Iik7CgkJaWYgKCF2YWx1ZVtpXSkKCQkJY21kW2ldID0gRlNDT05GSUdfU0VUX0ZMQUc7Cgl9CgoJ
Y21kW2ldID0gRlNDT05GSUdfQ01EX0NSRUFURTsKCWtleVtpXSA9IE5VTEw7Cgl2YWx1ZVtpXSA9
IE5VTEw7CgoJZm9yIChpID0gMDsgaSAhPSBtYXhfZW50cmllczsgaSsrKSB7CgkJcHJpbnRmKCJm
c2NvbmZpZygweCV4LCAlcywgJXMsIDApXG4iLCBjbWRbaV0sIGtleVtpXSwgdmFsdWVbaV0pOwoJ
CXJldCA9IGZzY29uZmlnKGZkLCBjbWRbaV0sIGtleVtpXSwgdmFsdWVbaV0sIDApOwoJCWlmIChy
ZXQgPCAwKSB7CgkJCWZwcmludGYoc3RkZXJyLCAiRmFpbGVkIGZzY29uZmlnKDIpOiAlc1xuIiwK
CQkJCXN0cmVycm9yKGVycm5vKSk7CgkJCXJldHVybiAtMTsKCQl9Cgl9CglyZXR1cm4gMDsKfQoK
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKewoJaW50IHJldCwgZnNmZCwgbWZkOwoJ
dW5zaWduZWQgaW50IG1vdW50X2F0dHJzID0gMDsKCWNoYXIgKm9wdHM7CgoJaWYgKGFyZ2MgIT0g
NSkgewoJCWZwcmludGYoc3RkZXJyLCAidXNhZ2U6ICVzIDx0eXBlPiA8c3JjPiA8dGd0PiA8b3B0
cz5cbiIsIGFyZ3ZbMF0pOwoJCXJldHVybiAxOwoJfQoKCWZzZmQgPSBmc29wZW4oYXJndlsxXSwg
MCk7CglpZiAoZnNmZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCBmc29wZW4oMik6
ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJCXJldHVybiAtMTsKCX0KCglpZiAoIXN0cm5jbXAg
KGFyZ3ZbMV0sICJuZnMiLCAzKSkKCQltb3VudF9hdHRycyA9IE1TX05PREVWOwoKCW9wdHMgPSBz
dHJkdXAoYXJndls0XSk7CgoJcmV0ID0gZnNjb25maWdfb3B0cyhmc2ZkLCBhcmd2WzJdLCBvcHRz
KTsKCWlmIChyZXQgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJGYWlsZWQgdG8gYWRkIG9wdGlv
bnM6ICVzXG4iLCBhcmd2WzRdKTsKCQljbG9zZShmc2ZkKTsKCQlyZXR1cm4gLTE7Cgl9Cglwcmlu
dGYoIlN1Y2Nlc3NmdWxseSBhZGRlZCBvcHRpb25zOiAlc1xuIiwgYXJndls0XSk7CgoJbWZkID0g
ZnNtb3VudChmc2ZkLCAwLCBtb3VudF9hdHRycyk7CglpZiAobWZkIDwgMCkgewoJCWZwcmludGYo
c3RkZXJyLCAiRmFpbGVkIGZzbW91bnQoMik6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwoJCXJl
dHVybiAtMTsKCX0KCWNsb3NlKGZzZmQpOwoKCXJldCA9IG1vdmVfbW91bnQobWZkLCAiIiwgQVRf
RkRDV0QsIGFyZ3ZbM10sIE1PVkVfTU9VTlRfRl9FTVBUWV9QQVRIKTsKCWlmIChyZXQgPCAwKSB7
CgkJZnByaW50ZihzdGRlcnIsICJGYWlsZWQgbW92ZV9tb3VudCgyKTogJXNcbiIsIHN0cmVycm9y
KGVycm5vKSk7CgkJcmV0dXJuIC0xOwoJfQoJY2xvc2UobWZkKTsKCglwcmludGYoIlN1Y2Nlc3Nm
dWxseSBtb3VudGVkIG9uOiAlc1xuIiwgYXJndlszXSk7CgoJcmV0dXJuIDA7Cn0K


--=-kuWbBwHyLOAMAixjfzuu--

