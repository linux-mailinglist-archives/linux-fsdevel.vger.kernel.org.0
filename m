Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED05119CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 15:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEBNKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 09:10:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60116 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726203AbfEBNKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 09:10:42 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x42DAZ2t005938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 May 2019 09:10:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0E7D9420023; Thu,  2 May 2019 09:10:35 -0400 (EDT)
Date:   Thu, 2 May 2019 09:10:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     ezemtsov@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Initial patches for Incremental FS
Message-ID: <20190502131034.GA25007@mit.edu>
References: <20190502040331.81196-1-ezemtsov@google.com>
 <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 07:19:52AM -0400, Amir Goldstein wrote:
> 
> This sounds very useful.
> 
> Why does it have to be a new special-purpose Linux virtual file?
> Why not FUSE, which is meant for this purpose?
> Those are things that you should explain when you are proposing a new
> filesystem,
> but I will answer for you - because FUSE page fault will incur high
> latency also after
> blocks are locally available in your backend store. Right?

From the documentation file in the first patch:

+Why isn't incremental-fs implemented via FUSE?
+----------------------------------------------
+TLDR: FUSE-based filesystems add 20-80% of performance overhead for target
+scenarios, and increase power use on mobile beyond acceptable limit
+for widespread deployment. A custom kernel filesystem is the way to overcome
+these limitations.
+

There are several paragraphs of more detail which I leave for the
interested reader to review....

						- Ted
