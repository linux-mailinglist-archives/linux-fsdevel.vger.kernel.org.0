Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF26311A1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfEBN0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 09:26:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50374 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfEBN0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 09:26:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hMBjE-0006B8-00; Thu, 02 May 2019 13:26:24 +0000
Date:   Thu, 2 May 2019 14:26:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>, ezemtsov@google.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Initial patches for Incremental FS
Message-ID: <20190502132623.GU23075@ZenIV.linux.org.uk>
References: <20190502040331.81196-1-ezemtsov@google.com>
 <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502131034.GA25007@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 09:10:34AM -0400, Theodore Ts'o wrote:

> +Why isn't incremental-fs implemented via FUSE?
> +----------------------------------------------
> +TLDR: FUSE-based filesystems add 20-80% of performance overhead for target
> +scenarios, and increase power use on mobile beyond acceptable limit
> +for widespread deployment. A custom kernel filesystem is the way to overcome
> +these limitations.
> +
> 
> There are several paragraphs of more detail which I leave for the
> interested reader to review....

Why not CODA, though, with local fs as cache?
