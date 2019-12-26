Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E060D12AA1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 04:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLZD4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 22:56:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41836 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbfLZD43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 22:56:29 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQ3u6FI016271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Dec 2019 22:56:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 50146420485; Wed, 25 Dec 2019 22:56:06 -0500 (EST)
Date:   Wed, 25 Dec 2019 22:56:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org,
        musl@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [musl] getdents64 lost direntries with SMB/NFS and buffer size <
 unknown threshold
Message-ID: <20191226035606.GB10794@mit.edu>
References: <20191120001522.GA25139@brightrain.aerifal.cx>
 <8736eiqq1f.fsf@mid.deneb.enyo.de>
 <20191120205913.GD16318@brightrain.aerifal.cx>
 <20191121175418.GI4262@mit.edu>
 <87a77g2o2o.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a77g2o2o.fsf@mid.deneb.enyo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 08:38:07PM +0100, Florian Weimer wrote:
> 32 bits are simply not enough storage space for the cookie.  Hashing
> just masks the presence of these bugs, but does not eliminate them
> completely.

Arguably 64 bits is not enough space for the cookie.  I'd be a lot
happier if it was 128 or 256 bits.  This is just one of those places
where POSIX is Really Broken(tm).  Unfortunately, NFS only gives us 64
bits for the readdir/readdirplus cookie, so we're kind of stuck with
it.

					- Ted
