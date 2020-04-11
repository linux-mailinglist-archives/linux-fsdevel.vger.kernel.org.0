Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C831A4E63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgDKGpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 02:45:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46750 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgDKGpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:45:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jN9tS-00Gl7K-Hs; Sat, 11 Apr 2020 06:45:30 +0000
Date:   Sat, 11 Apr 2020 07:45:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Askar Safin <safinaskar@mail.ru>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: What about adding AT_NO_AUTOMOUNT analogue to openat2?
Message-ID: <20200411064530.GL23230@ZenIV.linux.org.uk>
References: <1586558501.806374941@f476.i.mail.ru>
 <20200411060236.swlgw6ymzikgcqxl@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411060236.swlgw6ymzikgcqxl@yavin.dot.cyphar.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 04:02:36PM +1000, Aleksa Sarai wrote:
> On 2020-04-11, Askar Safin <safinaskar@mail.ru> wrote:
> > What about adding stat's AT_NO_AUTOMOUNT analogue to openat2?
> 
> There isn't one. I did intend to add RESOLVE_NO_AUTOMOUNTS after openat2
> was merged -- it's even mentioned in the commit message -- but I haven't
> gotten around to it yet. The reason it wasn't added from the outset was
> that I wasn't sure if adding it would be as simple as the other
> RESOLVE_* flags.
> 
> Note that like all RESOLVE_* flags, it would apply to all components so
> it wouldn't be truly analogous with AT_NO_AUTOMOUNT (though as I've
> discussed at length on this ML, most people do actually want the
> RESOLVE_* semantics). But you can emulate the AT_* ones much more easily
> with RESOLVE_* than vice-versa).

Er...  Not triggering automount on anything but the last component means
failing with ENOENT.  *All* automount points are empty and are bloody
well going to remain such, as far as I'm concerned.
