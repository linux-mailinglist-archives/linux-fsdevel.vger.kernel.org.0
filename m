Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283C5BEA98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiITPzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITPzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:55:45 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47543610;
        Tue, 20 Sep 2022 08:55:41 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36382)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oafay-00BoIG-CD; Tue, 20 Sep 2022 09:55:36 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:59828 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oafaw-004fTi-Nm; Tue, 20 Sep 2022 09:55:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        ark.email@gmail.com, bjorn3_gh@protonmail.com, bobo1239@web.de,
        bonifaido@gmail.com, boqun.feng@gmail.com, davidgow@google.com,
        dev@niklasmohrin.de, dsosnowski@dsosnowski.pl, foxhlchen@gmail.com,
        gary@garyguo.net, geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@kloenk.de, milan@mdaverde.com,
        mjmouse9999@gmail.com, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, thesven73@gmail.com,
        viktor@v-gar.de, Andreas Hindborg <andreas.hindborg@wdc.com>
References: <20220805154231.31257-13-ojeda@kernel.org>
        <Yu5Bex9zU6KJpcEm@yadro.com>
        <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
        <Yu6BXwtPZwYPIDT6@casper.infradead.org>
        <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
        <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
        <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
        <YyivY6WIl/ahZQqy@wedsonaf-dev>
        <CAHk-=whm5Ujw-yroDPZWRsHK76XxZWF1E9806jNOicVTcQC6jw@mail.gmail.com>
        <Yyjut3MHooCwzHRc@wedsonaf-dev>
        <CAHk-=wityPWw4YkHeMNU4iGanyiC3UwDRhbOHYCJrhB2paCGwA@mail.gmail.com>
        <CAFRnB2VPpLSMqQwFPEjZhde8+-c6LLms54QkMt+wZPjOTULESw@mail.gmail.com>
        <CAHk-=wiyD6KqZN8jFkMHPRPxrbyJEUDRP6+WaH9Q9hjDB5i1zg@mail.gmail.com>
        <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
Date:   Tue, 20 Sep 2022 10:55:27 -0500
In-Reply-To: <CAHk-=wj6sDFk8ZXSEKUMj-J9zfrMSSO3jhBEaveVaJSUpr=O=w@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 19 Sep 2022 17:15:13 -0700")
Message-ID: <87a66uxcpc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oafaw-004fTi-Nm;;;mid=<87a66uxcpc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/feQ3pgxQ1gVLYi+MOVKIy82mZEHw2pBM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1073 ms - load_scoreonly_sql: 0.42 (0.0%),
        signal_user_changed: 25 (2.3%), b_tie_ro: 17 (1.6%), parse: 4.5 (0.4%),
         extract_message_metadata: 30 (2.8%), get_uri_detail_list: 2.3 (0.2%),
        tests_pri_-1000: 17 (1.6%), compile_eval: 33 (3.0%), tests_pri_-950:
        3.1 (0.3%), tests_pri_-900: 2.3 (0.2%), tests_pri_-90: 523 (48.8%),
        check_bayes: 505 (47.1%), b_tokenize: 12 (1.2%), b_tok_get_all: 13
        (1.2%), b_comp_prob: 4.7 (0.4%), b_tok_touch_all: 468 (43.7%),
        b_finish: 2.5 (0.2%), tests_pri_0: 433 (40.4%), check_dkim_signature:
        1.28 (0.1%), check_dkim_adsp: 3.8 (0.4%), poll_dns_idle: 1.13 (0.1%),
        tests_pri_10: 2.5 (0.2%), tests_pri_500: 20 (1.9%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Sep 19, 2022 at 4:58 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> This is not some kind of "a few special things".
>>
>> This is things like absolutely _anything_ that allocates memory, or
>> takes a lock, or does a number of other things.
>
> Examples of "number of other things" ends up being things like
> "accessing user memory", which depending on what you are doing may be
> very common too.
>
> And btw, it's not only about the (multiple kinds of) atomic regions.
>
> We have other context rules in the kernel too, like "does floating
> point or vector unit calculations". Which you can actually do, but
> only in a kernel_fpu_begin/kernel_fpu_end region.
>
> Now, the floating point thing is rare enough that it's probably fine
> to just say "no floating point at all in Rust code".  It tends to be
> very special code, so you'd write it in C or inline assembly, because
> you're doing special things like using the vector unit for crypto
> hashes using special CPU instructions.

I just want to point out that there are ways of representing things like
the context you are running in during compile time.  I won't argue they
are necessarily practical, but there are ways and by exploring those
ways some practical solutions may result.

Instead of saying:
spin_lock(&lock);
do_something();
spin_unlock(&lock);

It is possible to say:
with_spin_lock(&lock, do_something());

This can be taken a step farther and with_spin_lock can pass a ``token''
say a structure with no members that disappears at compile time that
let's the code know it has the spinlock held.

In C I would do:
struct have_spin_lock_x {
	// nothing
};

do_something(struct have_spin_lock_x context_guarantee)
{
	...;
}

I think most of the special contexts in the kernel can be represented in
a similar manner.  A special parameter that can be passed and will
compile out.

I don't recall seeing anything like that tried in the kernel so I don't
know if it makes sense or if it would get too wordy to live, but it is
possible.  If passing a free context parameter is not too wordy it would
catch silly errors, and would hopefully leave more mental space for
developers to pay attention to the other details of the problems they
are solving.

*Shrug*  I don't know if rust allows for free parameters like that and
if it does I don't know if it would be cheap enough to live.

Eric
