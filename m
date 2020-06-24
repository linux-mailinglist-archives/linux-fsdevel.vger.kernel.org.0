Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFE207C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbgFXTsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 15:48:52 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:34814
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391313AbgFXTsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593028129; bh=7LhNJLz4g/G53x6mte5Ednv74jq/i1xGZKI6lb6VndM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PD7enlToaK05zSfXLx0TWcF+GuekhJ2MOetfAk+Lgkg25AJ5lE2/rhoLbwFv+ipxTyAgqzXMqx8FFHrrxKrL0y/FU6QfWtjSJrzN5lAI931loXcoQ6ZU5kKeEPBHKa+bhqNeT6L5EcSv/ez3lf9tRlKBvVEh75WTuOinNK3EcXyXYTsFUwv43Bk/RozQ4ea2Ota5gfx/jnVJC/sJca7EVh/hp77se9CkdZGAFh+2YqDbVzEoGoun9XmNaSkXhxPO8pI17tgcipRZmZrioGyr2w7XaJSZHb/PmJAUWMXbNcUt9s1sRg6iUkz1ybiGzhbxXWCTmu3XWkiKv/CIOlDUcw==
X-YMail-OSG: 4dNH4BUVM1l.hgeQja.X_7x47MkG8C1khh7boptzvTd0QYMFZbZxotrz7Rd5d70
 sLOuzFVxZogjvza78gAHqZpToDPhGjk5V8.Gefl8T7e_t3CTHD5M.yRodGvZaKLp59Lk3HihY5TV
 tvr1MFvrBC4SMnwBdmxxx0pRpXdIZuj1tEu55r_0fQG7P3MSFFkOeKqb3Bf5.eXbLef6lWqW.gQo
 g4Up8zNVtCjdLu18kgTTcLjrY9tw7rXjPi9NjfGUeB5FuQYx2_0J2RVMYHLVXV3DH0AJkr824bji
 cKYep0MOosUOjDH2gK5f936H.bGuayUyPzj5oTXJI62.y6blBDha8GEiVLwmt4HZc2z3habBRAiV
 LEvxc0XT0DTJmLtW3N7g2RWqYhTZjtY5tzqifjhBvxli__MvEvV4j3kMx_ogOCxPnhiZZXLd1aFs
 pzx3kykV6miYPBmppKAGeacPg8fC_HdGrACOQwj2WQsTqROizeAmv0iaBGChPQSfw4OshapqyNqw
 uzuRK0hfMtjlvd0Wf.7CEJIyclIMGrZOUVUHdtgD7RayxL9HMXYp0lTikzDsVmbSfgOsfXxb5N1f
 l9qhnrRZJ.LA6U26dw3nQLue.EfFPnEhqRTx13fm8I7Gmj_8qjhQ5ZCqYLrsdS9DMoJY3iJHFXEB
 6qf3eixny3_jvt4IZMQcytEYMmyI2HxCt5nkq7ccS70QlJFmrG_xEkuJgDJX6qTOxlmXqn43mtfH
 6JEOXRBDSrF3RRBZQ1t6mTtu2T0sxz2K13_cFWMvHwLMa5P9_iWWtz6NKlS7YpMSPDYkf1hKPG5j
 ski0OfGekrEvfhktvtP.bd9WVPkNAdOG3wehfcrEB9wCVN4uAaeyt0wdm_aTlLzieJY2HPZwIdH.
 IHE0D5fb4IqdtomH1jUAoo0L6aAURV8fgBheLPkwhBtkVQ2f53PPDEGVT0PwHBq2o5MRGY6vevJS
 m1CKbL20UYud17JwmNFKKm6wsMRE0X_11tRRQ2XexHU6r6ikHy8W0Wtf8uZ.bkt4L9TmZbZel3VM
 dIthO9PKSvEHRhuFHlfWCt0c1SurI_tWgbZy7wa9kAnB7AYNa_SN2IQ_vO1uuovRulgMyqtn33S.
 9xOzPSZ7UPmPNCdAxqjY0hpyYJYlrxZ0stIGdOwo2Ds99mDu1k151MRZCWU5utltmVs7CZdO1_Vy
 B3hY7lR2EvDPu8U4AuYC_QNXJ0GjjCtYfr.rUZnkLcWmNQ9GBjqSU79ylqACP9mEIhuF95pxCWZN
 Urvq7HAzKtk6DPXw9fXJvh_QUhCkBQ0kWWqKZitHamUsHAQ2ecQzBndacUcIzvr6IY_VE3Z0ibib
 dSUw7.2rr_QbpAS0sdRR.hhtM4gp4aFRVT59j5XFd693uvIu56c1Y3yIkESd.ruhHYvJWX_mgZO6
 fF8o05nQbdgnbJz4RS_KI8XgD9k0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jun 2020 19:48:49 +0000
Received: by smtp425.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID da9a592d2a59cb9cfca3dabc33561ece;
          Wed, 24 Jun 2020 19:48:47 +0000 (UTC)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>,
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
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
 <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <b4a805e7-e009-dfdf-d011-be636ce5c4f5@i-love.sakura.ne.jp>
 <20200624040054.x5xzkuhiw67cywzl@ast-mbp.dhcp.thefacebook.com>
 <5254444e-465e-6dee-287b-bef58526b724@i-love.sakura.ne.jp>
 <20200624063940.ctzhf4nnh3cjyxqi@ast-mbp.dhcp.thefacebook.com>
 <321b85b4-95f0-2f9b-756a-8405adc97230@i-love.sakura.ne.jp>
 <748ef005-7f64-ab9b-c767-c617ec995df4@schaufler-ca.com>
 <20200624175408.kwc562ofnfhmy674@ast-mbp.dhcp.thefacebook.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <8330277b-c399-c1d1-bf28-f253ba584c1a@schaufler-ca.com>
Date:   Wed, 24 Jun 2020 12:48:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624175408.kwc562ofnfhmy674@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16138 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/2020 10:54 AM, Alexei Starovoitov wrote:
> On Wed, Jun 24, 2020 at 08:41:37AM -0700, Casey Schaufler wrote:
>> On 6/24/2020 12:05 AM, Tetsuo Handa wrote:
>>> Forwarding to LSM-ML again. Any comments?
>> Hey, BPF folks - you *really* need to do better about keeping the LSM
>> community in the loop when you're discussing LSM issues.=20
>>
>>> On 2020/06/24 15:39, Alexei Starovoitov wrote:
>>>> On Wed, Jun 24, 2020 at 01:58:33PM +0900, Tetsuo Handa wrote:
>>>>> On 2020/06/24 13:00, Alexei Starovoitov wrote:
>>>>>>> However, regarding usermode_blob, although the byte array (which =
contains code / data)
>>>>>>> might be initially loaded from the kernel space (which is protect=
ed), that byte array
>>>>>>> is no longer protected (e.g. SIGKILL, strace()) when executed bec=
ause they are placed
>>>>>>> in the user address space. Thus, LSM modules (including pathname =
based security) want
>>>>>>> to control how that byte array can behave.
>>>>>> It's privileged memory regardless. root can poke into kernel or an=
y process memory.
>>>>> LSM is there to restrict processes running as "root".
>>>> hmm. do you really mean that it's possible for an LSM to restrict CA=
P_SYS_ADMIN effectively?
>> I think that SELinux works hard to do just that. SELinux implements it=
's own
>> privilege model that is tangential to the capabilities model.
> of course. no argument here.
>
>> More directly, it is simple to create a security module to provide fin=
er privilege
>> granularity than capabilities. I have one lurking in a source tree, an=
d I would
>> be surprised if it's the only one waiting for the next round of LSM st=
acking.
> no one is arguing with that either.
>
>>>> LSM can certainly provide extra level of foolproof-ness against acci=
dental
>>>> mistakes, but it's not a security boundary.
>> Gasp! Them's fight'n words. How do you justify such an outrageous clai=
m?
> .. for root user processes.
> What's outrageous about that?
> Did you capture the context or just replying to few sentences out of th=
e context?

As I mentioned above, you need to include the LSM list in these discussio=
ns.
If you don't want "out of context" comments. I replied to what's presente=
d.
And regardless of the context, saying that an LSM can't provide a securit=
y
boundary for "root user processes" is just wrong. Obviously there's been =
more
to the conversation than is included here.


