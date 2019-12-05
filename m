Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2821146BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 19:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfLESSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 13:18:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:51778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfLESSR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:18:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19D9CAEF9;
        Thu,  5 Dec 2019 18:18:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B1D0EDA733; Thu,  5 Dec 2019 19:18:09 +0100 (CET)
Date:   Thu, 5 Dec 2019 19:18:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pipe: Notification queue preparation
Message-ID: <20191205181809.GX2734@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-block@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191205172127.GW2734@suse.cz>
 <20191205125826.GK2734@twin.jikos.cz>
 <31452.1574721589@warthog.procyon.org.uk>
 <1593.1575554217@warthog.procyon.org.uk>
 <21493.1575566720@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21493.1575566720@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:25:20PM +0000, David Howells wrote:
> I've just posted a couple of patches - can you check to see if they fix your
> problem?
> 
> https://lore.kernel.org/linux-fsdevel/157556649610.20869.8537079649495343567.stgit@warthog.procyon.org.uk/T/#t

Not fixed, the test still hangs with the same call stack.
