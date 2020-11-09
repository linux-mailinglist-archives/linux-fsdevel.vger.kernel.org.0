Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2C2AC4E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgKITWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 14:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:58452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbgKITWR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:22:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EB9DAB95;
        Mon,  9 Nov 2020 19:22:15 +0000 (UTC)
Date:   Mon, 9 Nov 2020 10:59:40 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Soheil Hassas Yeganeh <soheil@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Guantao Liu <guantaol@google.com>
Subject: Re: [PATCH 0/8] simplify ep_poll
Message-ID: <20201109185940.logxhnbe4wjotgkb@linux-p48b.lan>
References: <20201106231635.3528496-1-soheil.kdev@gmail.com>
 <20201107174343.d94369d044c821fb8673bafd@linux-foundation.org>
 <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACSApva7rcbvtSyV6XY0q3eFQqmPXV=0zY9X1FPKkUk-hSodpA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 07 Nov 2020, Soheil Hassas Yeganeh wrote:
>FWIW, I also stress-tested the patch series applied on top of
>linux-next/master for a couple of hours.

Out of curiosity, what exactly did you use for testing?

Thanks,
Davidlohr
