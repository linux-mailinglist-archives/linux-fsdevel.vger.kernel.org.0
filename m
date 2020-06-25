Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC9209EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbgFYM4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403941AbgFYM4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:56:22 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC0C061573;
        Thu, 25 Jun 2020 05:56:22 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p82so4861860oif.1;
        Thu, 25 Jun 2020 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGKi64WQintPpZ0PiJ6dW4tMBiq9KIeg0n+W/5g1/1c=;
        b=qXFNVuI1GGW2k3Ub8vf0pIfZerRDNDUPm4nHq11ub38zVd0nCBMQw5b/FyZJ1uqSsh
         TH8gF8Es+pfp+S1FwVMF9S7sgNuNrOGAavQ41jEE/9bNtqQgdE8EUE40zexH4C7w8JI+
         D/yF1gydpJHTeEfEOgF1at+ol9s8ZooATsbrmqsGq26ISSzTGloSCsI5xJdK8HLovNIq
         58xBf42fE/2+v97ZZoqxPCvx0heSwtqrDoZBFGAOafrOKpA5UhzqB3hwdkhQgZpXTdyh
         c5D5+bMcvqrclRuvLUq2PuxPsR7RHnTgCqJpFMW5MaGn/seqRDqNqDPi59jqHNAHcnHN
         gVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGKi64WQintPpZ0PiJ6dW4tMBiq9KIeg0n+W/5g1/1c=;
        b=HzHMTodCEmqsTQMgrWb96WFlCiv/D/FeUT8w1dFL64bt66qEo946ogOj++uRIZCydZ
         owCXrHAl96PVk8bCvQiddDaLXDaIbI3EM5T2wSbB3MifvvE40bURJOvQOUKH0QXIUBSc
         KtqN4ccII05F+Ml4mPk6tZHzFIriluvsArMC9T2rBDMlk8FPLS3595YoYOfOPJ8mLA8K
         FgjpGQZlwYKGc73fFYhzrd5GQWBwUu8gtX2Uniuf/gHuPcLq8NtKKqHhzdIOadxQVfZQ
         K2Jl8PtrwnlXLV1L/KNGCEZ9flAXpjy+ed/BRulWLNfkUFc2io29B6ibpl9VOVeETV+a
         2VeA==
X-Gm-Message-State: AOAM533bsq0xfkTvW/ZAOmnFH7r5fgtkXI3tk1dHkTthT/AUJu2rnPWx
        Vwq4eS/eI16IpWWJNfeeo+LXoI1vzOm5HKhXnRY=
X-Google-Smtp-Source: ABdhPJyoY1+FUwr2b7djALCSD/8Mjarm6gnmnjoZTM4ivo29bOovJFfTo6/3Hq7pq3SSrj7/mGNoKbm2E34rC02dJz0=
X-Received: by 2002:aca:3283:: with SMTP id y125mr2042257oiy.140.1593089781523;
 Thu, 25 Jun 2020 05:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <87d066vd4y.fsf@x220.int.ebiederm.org> <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org> <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org> <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
In-Reply-To: <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 08:56:10 -0400
Message-ID: <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 7:16 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> What is unhappy for pathname based LSMs is that fork_usermode_blob() creates
> a file with empty filename. I can imagine that somebody would start abusing
> fork_usermode_blob() as an interface for starting programs like modprobe, hotplug,
> udevd and sshd. When such situation happened, how fork_usermode_blob() provides
> information for identifying the intent of such execve() requests?
>
> fork_usermode_blob() might also be an unhappy behavior for inode based LSMs (like
> SELinux and Smack) because it seems that fork_usermode_blob() can't have a chance
> to associate appropriate security labels based on the content of the byte array
> because files are created on-demand. Is fork_usermode_blob() friendly to inode
> based LSMs?

No, because we cannot label the inode based on the program's purpose
and therefore cannot configure an automatic transition to a suitable
security context for the process, unlike call_usermodehelper(). It is
important to note that the goal of such transitions is not merely to
restrict the program from doing bad things but also to protect the
program from untrustworthy inputs, e.g. one can run kmod/modprobe in a
domain that can only read from authorized kernel modules, prevent
following untrusted symlinks, etc.  Further, at present, the
implementation creates the inode via shmem_kernel_file_setup(), which
is supposed to be for inodes private to the kernel not exposed to
userspace (hence marked S_PRIVATE), which I believe in this case will
end up leaving the inode unlabeled but still end up firing checks in
the bprm hooks on the file inode, thereby potentially yielding denials
in SELinux on the exec of unlabeled files.  Not exactly what we would
want.  If users were to switch from using call_usermodehelper() to
fork_usermode_blob() we would need them to label the inode in some
manner to reflect the program purpose prior to exec.  I suppose they
could pass in some string key and SELinux could look it up in policy
to get a context to use or something.

On a different note, will the usermode blob be measured by IMA prior
to execution?  What ensures that the blob was actually embedded in the
kernel image and wasn't just supplied as data through exploitation of
a kernel vulnerability or malicious kernel module?  Yes, things are
already bad at that point but it would be good to be able to detect
launch of the malicious userspace payload regardless (kernel exploit
can't undo the measurement extended into the TPM even if it tampers
with the IMA measurement list in the kernel, nor fake a quote signed
by the TPM).
