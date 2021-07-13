Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302A63C780C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhGMUiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 16:38:04 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:33218 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhGMUiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:38:04 -0400
X-Greylist: delayed 1265 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jul 2021 16:38:04 EDT
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3P5N-000NaR-2y; Tue, 13 Jul 2021 20:32:57 +0000
Date:   Tue, 13 Jul 2021 20:32:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO34eTRpEQKuCzpW@zeniv-ca.linux.org.uk>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <YO31DWtFMZuqF8tm@zeniv-ca.linux.org.uk>
 <fac8ca82-8e9e-cbcf-2e68-b2b281ab0127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac8ca82-8e9e-cbcf-2e68-b2b281ab0127@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 13, 2021 at 01:24:06PM -0700, Randy Dunlap wrote:

> Hi Al,
> 
> Where would you prefer for kernel-doc changes in fs/*.[ch] be merged?
> 
> E.g., from June 27:
> 
> https://lore.kernel.org/linux-fsdevel/20210628014613.11296-1-rdunlap@infradead.org/

Umm...  I'd been under impression that kernel-doc stuff in general goes
through akpm, TBH.  I don't remember ever having a problem with your
patches of that sort; I can grab that kind of stuff, but if there's
an existing pipeline for that I'd just as well leave it there...
