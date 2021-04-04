Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6248C3537C6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Apr 2021 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhDDK1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Apr 2021 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDDK1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Apr 2021 06:27:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA8C061756;
        Sun,  4 Apr 2021 03:27:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z136so801133iof.10;
        Sun, 04 Apr 2021 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxwDWRu7ltAIzDZSPbxZIazkho2F6alYnyBWwB5plIs=;
        b=q9lf4AIG6Xekv7VnVIgNP6Lo5bCfQZjRPAYfuIgKFnVUfvUxkfILYzzX8wLxejf7GM
         mKJrdErwFz1PmH/cKPxYmXCbij3bcVPHGYAOz+7UmgmkLXtX/qVElyP2hGbkdKzYCAgy
         cvxrDBX79qWVA1a6a996X2zRa4gnZNKOGKD+mlwQrL+mxvUf3vFHJhXOzchU4amiFdU5
         QtVvy6XoQpoOC3HXEhUGcpi8SjBY/NC8QhmSBw93/8xTT6IvlNBANODCA+bFE2F/dUsM
         9JcQJ06wfy/+YQpjlCTQm+pSEsVKpHLeZJBVn8wFhJY9M8IFuyygJmVYPawW5ZOZKljh
         Lr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxwDWRu7ltAIzDZSPbxZIazkho2F6alYnyBWwB5plIs=;
        b=i64hLguqGp5IM9TDba6BZm9JF+dQRIpu9fC2J2k3VBIqOyz0+ANcRQoWpftBDtaKh5
         7PM7lempMrYABqQ5b/9jYRA3tdRty59vVCq0zQFygVxFa1cZ2cGSkLpriPXazxgwhDEs
         gc56sa4ANjPZ8flSHh2QNFI0CofqDoFQsAgho0QxG4+oewll4kCSNqId6APVhOQPmvkp
         H9oM0Rjnt9sWezYOg3eXqwdmXWY0y0AObVvViYApnPi52zCiBHL8TpxtKkvhkG/Owv8e
         69vjO9wvayYtCr9a/inJ/lo4DERWcHytbCPOgtrSFz8e9yrj7+cDE37X6ZsVQ2cZ1WCw
         QwFg==
X-Gm-Message-State: AOAM533nwy+acqRiInsZGaZwK2smNLz42Jgor+a8h/c0vuvTPtmX9b2R
        VhKt9cTXCW5SoxlKNEysiLIdCUe9RbT6rPVRcOHhJ6l01yA=
X-Google-Smtp-Source: ABdhPJzcqUTlZefShbxXPJrb0LxbftYQQxypt5yS7OnKE1xFolCIutrY+Ccfqu/6C7dh8N65HXFmkiaa0liz5bAdCW8=
X-Received: by 2002:a05:6602:2a4c:: with SMTP id k12mr16070418iov.64.1617532052677;
 Sun, 04 Apr 2021 03:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 4 Apr 2021 13:27:21 +0300
Message-ID: <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
Subject: Re: LSM and setxattr helpers
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000069bad105bf23075c"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000069bad105bf23075c
Content-Type: text/plain; charset="UTF-8"

[forking question about security modules]

>
> Nice thing about vfs_{set,remove}xattr() is that they already have
> several levels of __vfs_ helpers and nfsd already calls those, so
> we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
> helpers to the common vfs_xxx helpers and add fsnotify hooks to
> the very few callers of __vfs_ helpers.
>
> nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
> do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
> __vfs_removexattr(), which does not generate event and does not
> check permissions - it looks like an oversight.
>
> The thing is, right now __vfs_setxattr_noperm() generates events,
> but looking at all the security/* callers, it feels to me like those are
> very internal operations and that "noperm" should also imply "nonotify".
>
> To prove my point, all those callers call __vfs_removexattr() which
> does NOT generate an event.
>
> Also, I *think* the EVM setxattr is something that usually follows
> another file data/metadata change, so some event would have been
> generated by the original change anyway.
>
> Mimi,
>
> Do you have an opinion on that?
>
> The question is if you think it is important for an inotify/fanotify watcher
> that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
> event when the IMA security blob changes.
>

Guys,

I was doing some re-factoring of the __vfs_setxattr helpers
and noticed some strange things.

The wider context is fsnotify_xattr() hooks inside internal
setxattr,removexattr calls. I would like to move those hooks
to the common vfs_{set,remove}xattr() helpers.

SMACK & SELINUX:
For the callers of __vfs_setxattr_noperm(),
smack_inode_setsecctx() and selinux_inode_setsecctx()
It seems that the only user is nfsd4_set_nfs4_label(), so it
makes sense for me to add the fsnotify_xattr() in nfsd context,
same as I did with other fsnotify_ hooks.

Are there any other expected callers of security_inode_setsecctx()
except nfsd in the future? If so they would need to also add the
fsnotify_xattr() hook, if at all the user visible FS_ATTRIB event is
considered desirable.

SMACK:
Just to be sure, is the call to __vfs_setxattr() from smack_d_instantiate()
guaranteed to be called for an inode whose S_NOSEC flag is already
cleared? Because the flag is being cleared by __vfs_setxattr_noperm().

EVM:
I couldn't find what's stopping this recursion:
evm_update_evmxattr() => __vfs_setxattr_noperm() =>
security_inode_post_setxattr() => evm_inode_post_removexattr() =>
evm_update_evmxattr()

It looks like the S_NOSEC should already be clear when
evm_update_evmxattr() is called(?), so it seems more logical to me to
call __vfs_setxattr() as there is no ->inode_setsecurity() hook for EVM.
Am I missing something?

It seems to me that updating the EVM hmac should not generate
a visible FS_ATTRIB event to listeners, because it is an internal
implementation detail and because update EVM hmac happens
following another change to the inode which anyway reports a
visible event to listeners.
Also, please note that evm_update_evmxattr() may also call
__vfs_removexattr() which does not call the fsnotify_xattr() hook.

IMA:
Similarly, ima_fix_xattr() should be called on an inode without
S_NOSEC flag and no other LSM should be interested in the
IMA hash update, right? So wouldn't it be better to use
__vfs_setxattr() in this case as well?

ima_fix_xattr() can be called after file data update, which again
will have other visible events, but it can also be called in "fix mode"
I suppose also when reading files? Still, it seems to me like an
internal implementation detail that should not generate a user
visible event.

If you agree with my proposed changes, please ACK the
respective bits of your subsystem from the attached patch.
Note that my patch does not contain the proposed change to
use __vfs_setxattr() in IMA/EVM.

Thanks,
Amir.

--00000000000069bad105bf23075c
Content-Type: text/plain; charset="US-ASCII"; 
	name="move-fsnotify_xattr-hooks-up-the-call-stack.patch.txt"
Content-Disposition: attachment; 
	filename="move-fsnotify_xattr-hooks-up-the-call-stack.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kn30ox670>
X-Attachment-Id: f_kn30ox670

RnJvbSA3NmRiM2JmODRhYzEzODNjOWMwYjdlNmY4MjY4YWIyNTI3ODczZDgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDIgQXByIDIwMjEgMTE6Mjg6MTMgKzAzMDAKU3ViamVjdDogW1BBVENIXSBmc25v
dGlmeTogbW92ZSBmc25vdGlmeV94YXR0cigpIGhvb2tzIHVwIHRoZSBjYWxsIHN0YWNrCgpNb3Zl
IHRoZSBmc25vdGlmeSBob29rcyBmcm9tIGludGVybmFsIF9fdmZzX3h4eCBoZWxwZXJzIGludG8g
dGhlCm1vcmUgY29tbW9uIHZmc194eHggaGVscGVycy4KCkFkZCB0aGUgZnNub3RpZnkgaG9va3Mg
dG8gdGhlIGNhbGxlcnMgb2YgdGhlIF9fdmZzX3h4eF9sb2NrZWQgaGVscGVycwpuZnNkIGFuZCBl
Y3J5cHRmcyAoZWNyeXB0ZnMgZ2FpbnMgYW4gZXZlbnQgb24gcmVtb3ZleGF0dHIpLgoKQWRkIHRo
ZSBmc25vdGlmeSBob29rcyB0byBuZnNkNF9zZXRfbmZzNF9sYWJlbCgpIHRvIGNvbXBlbnNhdGUg
Zm9yIHRoZQpsb3N0IGZzbm90aWZ5IGhvb2tzIGZyb20gdGhlIExTTSBpbm9kZV9zZXRzZWNjdHgo
KSBob29rcyBvZiBzbWFjayBhbmQKc2VsaW51eC4KCkxlYXZlIGV2bV91cGRhdGVfZXZteGF0dHIo
KSBhbmQgaW1hX2ZpeF94YXR0cigpIGNhbGxlcnMgd2l0aG91dCBmc25vdGlmeQpob29rcywgYmVj
YXVzZSB0aGUgdXBkYXRlIG9mIElNQS9FVk0gaGFzaCBzZWVtcyBsaWtlIGluZm9ybWF0aW9uIHRo
YXQKbWF5IG5vdCBuZWVkIHRvIGJlIGV4cG9zZWQgdG8gZnNub3RpZnkgd2F0Y2hlcnMgYW5kIGlu
IG1vc3QgY2FzZXMsIHRoZQpoYXNoIHVwZGF0ZSB3aWxsIGZvbGxvdyB1cGRhdGUgb2YgaW5vZGUg
ZGF0YSBvciBtZXRhZGF0YSB0aGF0IHdpbGwgaGF2ZQphbnl3YXkgZ2VuZXJhdGVkIGFuIGZzbm90
aWZ5IGV2ZW50LgoKQ2M6IFR5bGVyIEhpY2tzIDxjb2RlQHR5aGlja3MuY29tPgpDYzogTWltaSBa
b2hhciA8em9oYXJAbGludXguaWJtLmNvbT4KQ2M6IEphbWVzIE1vcnJpcyA8am1vcnJpc0BuYW1l
aS5vcmc+CkNjOiBTZXJnZSBFLiBIYWxseW4gPHNlcmdlQGhhbGx5bi5jb20+CkNjOiBDYXNleSBT
Y2hhdWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+CkNjOiBQYXVsIE1vb3JlIDxwYXVsQHBh
dWwtbW9vcmUuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21h
aWwuY29tPgotLS0KIGZzL2VjcnlwdGZzL2lub2RlLmMgfCAgNSArKysrKwogZnMvbmZzZC92ZnMu
YyAgICAgICB8ICA2ICsrKysrKwogZnMveGF0dHIuYyAgICAgICAgICB8IDE0ICsrKysrKy0tLS0t
LS0tCiAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvZWNyeXB0ZnMvaW5vZGUuYyBiL2ZzL2VjcnlwdGZzL2lub2RlLmMKaW5k
ZXggMThlOTI4NWZiYjRjLi43ZjI0ODMwZThjNWMgMTAwNjQ0Ci0tLSBhL2ZzL2VjcnlwdGZzL2lu
b2RlLmMKKysrIGIvZnMvZWNyeXB0ZnMvaW5vZGUuYwpAQCAtMTYsNiArMTYsNyBAQAogI2luY2x1
ZGUgPGxpbnV4L25hbWVpLmg+CiAjaW5jbHVkZSA8bGludXgvbW91bnQuaD4KICNpbmNsdWRlIDxs
aW51eC9mc19zdGFjay5oPgorI2luY2x1ZGUgPGxpbnV4L2Zzbm90aWZ5Lmg+CiAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L3hhdHRyLmg+CiAjaW5jbHVkZSA8YXNtL3Vu
YWxpZ25lZC5oPgpAQCAtMTA0Nyw2ICsxMDQ4LDggQEAgZWNyeXB0ZnNfc2V0eGF0dHIoc3RydWN0
IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCX0KIAlpbm9kZV9sb2NrKGxv
d2VyX2lub2RlKTsKIAlyYyA9IF9fdmZzX3NldHhhdHRyX2xvY2tlZCgmaW5pdF91c2VyX25zLCBs
b3dlcl9kZW50cnksIG5hbWUsIHZhbHVlLCBzaXplLCBmbGFncywgTlVMTCk7CisJaWYgKCFyYykK
KwkJZnNub3RpZnlfeGF0dHIobG93ZXJfZGVudHJ5KTsKIAlpbm9kZV91bmxvY2sobG93ZXJfaW5v
ZGUpOwogCWlmICghcmMgJiYgaW5vZGUpCiAJCWZzc3RhY2tfY29weV9hdHRyX2FsbChpbm9kZSwg
bG93ZXJfaW5vZGUpOwpAQCAtMTExMyw2ICsxMTE2LDggQEAgc3RhdGljIGludCBlY3J5cHRmc19y
ZW1vdmV4YXR0cihzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBpbm9kZSAqaW5vZGUsCiAJ
fQogCWlub2RlX2xvY2sobG93ZXJfaW5vZGUpOwogCXJjID0gX192ZnNfcmVtb3ZleGF0dHIoJmlu
aXRfdXNlcl9ucywgbG93ZXJfZGVudHJ5LCBuYW1lKTsKKwlpZiAoIXJjKQorCQlmc25vdGlmeV94
YXR0cihsb3dlcl9kZW50cnkpOwogCWlub2RlX3VubG9jayhsb3dlcl9pbm9kZSk7CiBvdXQ6CiAJ
cmV0dXJuIHJjOwpkaWZmIC0tZ2l0IGEvZnMvbmZzZC92ZnMuYyBiL2ZzL25mc2QvdmZzLmMKaW5k
ZXggNjExYzRiOGYzYzc0Li43NWUyMmFiMTdjY2EgMTAwNjQ0Ci0tLSBhL2ZzL25mc2QvdmZzLmMK
KysrIGIvZnMvbmZzZC92ZnMuYwpAQCAtNTIwLDYgKzUyMCw4IEBAIF9fYmUzMiBuZnNkNF9zZXRf
bmZzNF9sYWJlbChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1Y3Qgc3ZjX2ZoICpmaHAsCiAK
IAlpbm9kZV9sb2NrKGRfaW5vZGUoZGVudHJ5KSk7CiAJaG9zdF9lcnJvciA9IHNlY3VyaXR5X2lu
b2RlX3NldHNlY2N0eChkZW50cnksIGxhYmVsLT5kYXRhLCBsYWJlbC0+bGVuKTsKKwlpZiAoIWhv
c3RfZXJyb3IpCisJCWZzbm90aWZ5X3hhdHRyKGRlbnRyeSk7CiAJaW5vZGVfdW5sb2NrKGRfaW5v
ZGUoZGVudHJ5KSk7CiAJcmV0dXJuIG5mc2Vycm5vKGhvc3RfZXJyb3IpOwogfQpAQCAtMjMxNSw2
ICsyMzE3LDggQEAgbmZzZF9yZW1vdmV4YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwLCBzdHJ1
Y3Qgc3ZjX2ZoICpmaHAsIGNoYXIgKm5hbWUpCiAKIAlyZXQgPSBfX3Zmc19yZW1vdmV4YXR0cl9s
b2NrZWQoJmluaXRfdXNlcl9ucywgZmhwLT5maF9kZW50cnksCiAJCQkJICAgICAgIG5hbWUsIE5V
TEwpOworCWlmICghcmV0KQorCQlmc25vdGlmeV94YXR0cihmaHAtPmZoX2RlbnRyeSk7CiAKIAlm
aF91bmxvY2soZmhwKTsKIAlmaF9kcm9wX3dyaXRlKGZocCk7CkBAIC0yMzQwLDYgKzIzNDQsOCBA
QCBuZnNkX3NldHhhdHRyKHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAsIHN0cnVjdCBzdmNfZmggKmZo
cCwgY2hhciAqbmFtZSwKIAogCXJldCA9IF9fdmZzX3NldHhhdHRyX2xvY2tlZCgmaW5pdF91c2Vy
X25zLCBmaHAtPmZoX2RlbnRyeSwgbmFtZSwgYnVmLAogCQkJCSAgICBsZW4sIGZsYWdzLCBOVUxM
KTsKKwlpZiAoIXJldCkKKwkJZnNub3RpZnlfeGF0dHIoZmhwLT5maF9kZW50cnkpOwogCiAJZmhf
dW5sb2NrKGZocCk7CiAJZmhfZHJvcF93cml0ZShmaHApOwpkaWZmIC0tZ2l0IGEvZnMveGF0dHIu
YyBiL2ZzL3hhdHRyLmMKaW5kZXggYjM0NDRlMDZjZGVkLi42YzBhYzMwMGI1MTkgMTAwNjQ0Ci0t
LSBhL2ZzL3hhdHRyLmMKKysrIGIvZnMveGF0dHIuYwpAQCAtMjEzLDExICsyMTMsOSBAQCBpbnQg
X192ZnNfc2V0eGF0dHJfbm9wZXJtKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywK
IAlpZiAoaW5vZGUtPmlfb3BmbGFncyAmIElPUF9YQVRUUikgewogCQllcnJvciA9IF9fdmZzX3Nl
dHhhdHRyKG1udF91c2VybnMsIGRlbnRyeSwgaW5vZGUsIG5hbWUsIHZhbHVlLAogCQkJCSAgICAg
ICBzaXplLCBmbGFncyk7Ci0JCWlmICghZXJyb3IpIHsKLQkJCWZzbm90aWZ5X3hhdHRyKGRlbnRy
eSk7CisJCWlmICghZXJyb3IpCiAJCQlzZWN1cml0eV9pbm9kZV9wb3N0X3NldHhhdHRyKGRlbnRy
eSwgbmFtZSwgdmFsdWUsCiAJCQkJCQkgICAgIHNpemUsIGZsYWdzKTsKLQkJfQogCX0gZWxzZSB7
CiAJCWlmICh1bmxpa2VseShpc19iYWRfaW5vZGUoaW5vZGUpKSkKIAkJCXJldHVybiAtRUlPOwpA
QCAtMjMwLDggKzIyOCw2IEBAIGludCBfX3Zmc19zZXR4YXR0cl9ub3Blcm0oc3RydWN0IHVzZXJf
bmFtZXNwYWNlICptbnRfdXNlcm5zLAogCiAJCQllcnJvciA9IHNlY3VyaXR5X2lub2RlX3NldHNl
Y3VyaXR5KGlub2RlLCBzdWZmaXgsIHZhbHVlLAogCQkJCQkJCSAgIHNpemUsIGZsYWdzKTsKLQkJ
CWlmICghZXJyb3IpCi0JCQkJZnNub3RpZnlfeGF0dHIoZGVudHJ5KTsKIAkJfQogCX0KIApAQCAt
Mjk5LDYgKzI5NSw4IEBAIHZmc19zZXR4YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91
c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKIAlpbm9kZV9sb2NrKGlub2RlKTsKIAllcnJv
ciA9IF9fdmZzX3NldHhhdHRyX2xvY2tlZChtbnRfdXNlcm5zLCBkZW50cnksIG5hbWUsIHZhbHVl
LCBzaXplLAogCQkJCSAgICAgIGZsYWdzLCAmZGVsZWdhdGVkX2lub2RlKTsKKwlpZiAoIWVycm9y
KQorCQlmc25vdGlmeV94YXR0cihkZW50cnkpOwogCWlub2RlX3VubG9jayhpbm9kZSk7CiAKIAlp
ZiAoZGVsZWdhdGVkX2lub2RlKSB7CkBAIC01MDAsMTAgKzQ5OCw4IEBAIF9fdmZzX3JlbW92ZXhh
dHRyX2xvY2tlZChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsCiAKIAllcnJvciA9
IF9fdmZzX3JlbW92ZXhhdHRyKG1udF91c2VybnMsIGRlbnRyeSwgbmFtZSk7CiAKLQlpZiAoIWVy
cm9yKSB7Ci0JCWZzbm90aWZ5X3hhdHRyKGRlbnRyeSk7CisJaWYgKCFlcnJvcikKIAkJZXZtX2lu
b2RlX3Bvc3RfcmVtb3ZleGF0dHIoZGVudHJ5LCBuYW1lKTsKLQl9CiAKIG91dDoKIAlyZXR1cm4g
ZXJyb3I7CkBAIC01MjIsNiArNTE4LDggQEAgdmZzX3JlbW92ZXhhdHRyKHN0cnVjdCB1c2VyX25h
bWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogCWlub2RlX2xvY2so
aW5vZGUpOwogCWVycm9yID0gX192ZnNfcmVtb3ZleGF0dHJfbG9ja2VkKG1udF91c2VybnMsIGRl
bnRyeSwKIAkJCQkJIG5hbWUsICZkZWxlZ2F0ZWRfaW5vZGUpOworCWlmICghZXJyb3IpCisJCWZz
bm90aWZ5X3hhdHRyKGRlbnRyeSk7CiAJaW5vZGVfdW5sb2NrKGlub2RlKTsKIAogCWlmIChkZWxl
Z2F0ZWRfaW5vZGUpIHsKLS0gCjIuMzAuMAoK
--00000000000069bad105bf23075c--
