Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31FD24133B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 00:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHJW3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgHJW3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:00 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B31C06174A;
        Mon, 10 Aug 2020 15:29:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5GHW-00DHrJ-VN; Mon, 10 Aug 2020 22:28:39 +0000
Date:   Mon, 10 Aug 2020 23:28:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] Add support for O_MAYEXEC
Message-ID: <20200810222838.GF1236603@ZenIV.linux.org.uk>
References: <20200723171227.446711-1-mic@digikod.net>
 <202007241205.751EBE7@keescook>
 <0733fbed-cc73-027b-13c7-c368c2d67fb3@digikod.net>
 <20200810202123.GC1236603@ZenIV.linux.org.uk>
 <30b8c003f49d4280be5215f634ca2c06@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30b8c003f49d4280be5215f634ca2c06@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:09:09PM +0000, David Laight wrote:
> > On Mon, Aug 10, 2020 at 10:11:53PM +0200, Mickaël Salaün wrote:
> > > It seems that there is no more complains nor questions. Do you want me
> > > to send another series to fix the order of the S-o-b in patch 7?
> > 
> > There is a major question regarding the API design and the choice of
> > hooking that stuff on open().  And I have not heard anything resembling
> > a coherent answer.
> 
> To me O_MAYEXEC is just the wrong name.
> The bit would be (something like) O_INTERPRET to indicate
> what you want to do with the contents.

... which does not answer the question - name of constant is the least of
the worries here.  Why the hell is "apply some unspecified checks to
file" combined with opening it, rather than being an independent primitive
you apply to an already opened file?  Just in case - "'cuz that's how we'd
done it" does not make a good answer...
