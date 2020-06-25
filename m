Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092B720A1C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 17:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405744AbgFYPWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 11:22:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58575 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404580AbgFYPWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:22:14 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05PFLFxY007936;
        Fri, 26 Jun 2020 00:21:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 26 Jun 2020 00:21:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05PFLFQo007932
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 26 Jun 2020 00:21:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org>
 <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
 <20200625132551.GB3526980@kroah.com>
 <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a34cf18a-f251-f4f1-ed7c-fb5e100df91d@i-love.sakura.ne.jp>
Date:   Fri, 26 Jun 2020 00:21:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/25 23:26, Stephen Smalley wrote:
> On Thu, Jun 25, 2020 at 9:25 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
>>> No, because we cannot label the inode based on the program's purpose
>>> and therefore cannot configure an automatic transition to a suitable
>>> security context for the process, unlike call_usermodehelper().
>>
>> Why, what prevents this?  Can you not just do that based on the "blob
>> address" or signature of it or something like that?  Right now you all
>> do this based on inode of a random file on a disk, what's the difference
>> between a random blob in memory?
> 
> Given some kind of key to identify the blob and look up a suitable
> context in policy, I think it would work.  We just don't have that
> with the current interface.  With /bin/kmod and the like, we have a
> security xattr assigned to the file when it was created that we can
> use as the basis for determining the process security context.

My understanding is that fork_usermode_blob() is intended to be able to run
without filesystems so that usermode blobs can start even before global init
program (pid=1) starts.

But SELinux's policy is likely stored inside filesystems which would be
accessible only after global init program (pid=1) started.

Therefore, I wonder whether SELinux can look up a suitable context in policy
even if "some kind of key to identify the blob" is provided.
Also, since (at least some of) usermode blob processes started via
fork_usermode_blob() will remain after SELinux loads policy from filesystems,
I guess that we will need a method for moving already running usermode blob
processes to appropriate security contexts.

Is my understanding/concerns correct?

