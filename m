Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03D421CB75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jul 2020 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgGLVCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 17:02:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59304 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:02:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 100401C0BE0; Sun, 12 Jul 2020 23:02:50 +0200 (CEST)
Date:   Sun, 12 Jul 2020 23:02:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/16] exec: Remove do_execve_file
Message-ID: <20200712210243.GB983@bug>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702164140.4468-10-ebiederm@xmission.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2020-07-02 11:41:34, Eric W. Biederman wrote:
> Now that the last callser has been removed remove this code from exec.

Typo "caller".

> For anyone thinking of resurrecing do_execve_file please note that

resurrecting?

> the code was buggy in several fundamental ways.
> 
> - It did not ensure the file it was passed was read-only and that
>   deny_write_access had been called on it.  Which subtlely breaks
>   invaniants in exec.

subtly, invariants?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
