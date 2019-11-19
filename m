Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B046101E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 09:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfKSIso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 03:48:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51612 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfKSIso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:48:44 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iWzBf-0000Gj-5N; Tue, 19 Nov 2019 09:48:39 +0100
Date:   Tue, 19 Nov 2019 09:48:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <msnitzer@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Scott Wood <swood@redhat.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH RT 1/2 v2] dm-snapshot: fix crash with the realtime kernel
Message-ID: <20191119084839.dvzfettd6vbvqd4w@linutronix.de>
References: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <alpine.LRH.2.02.1911121057490.12815@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-12 11:09:51 [-0500], Mikulas Patocka wrote:
> Snapshot doesn't work with realtime kernels since the commit f79ae415b64c.
> hlist_bl is implemented as a raw spinlock and the code takes two non-raw
> spinlocks while holding hlist_bl (non-raw spinlocks are blocking mutexes
> in the realtime kernel).

this series is still on the list of things for me to look at…

Sebastian
