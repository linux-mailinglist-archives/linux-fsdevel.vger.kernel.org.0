Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE68A070B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1QPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 12:15:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbfH1QPo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4527AFE8;
        Wed, 28 Aug 2019 16:15:42 +0000 (UTC)
Date:   Wed, 28 Aug 2019 18:15:40 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Neuling <mikey@neuling.org>,
        David Hildenbrand <david@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/4] fs: always build llseek.
Message-ID: <20190828181540.21fa33a4@naga>
In-Reply-To: <20190828151552.GA16855@infradead.org>
References: <cover.1566936688.git.msuchanek@suse.de>
        <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
        <20190828151552.GA16855@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 28 Aug 2019 08:15:52 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Aug 27, 2019 at 10:21:06PM +0200, Michal Suchanek wrote:
> > 64bit !COMPAT does not build because the llseek syscall is in the tables.  
> 
> Well, this will bloat thinkgs like 64-bit RISC-V for no good reason.
> Please introduce a WANT_LSEEK like symbol that ppc64 can select instead.

It also builds when llseek is marked as 32bit only in syscall.tbl

It seems it was handled specially in some way before syscall.tbl was
added, though (removed in ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5)

Thanks

Michal
