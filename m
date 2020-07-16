Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8892227F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGPQAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 12:00:25 -0400
Received: from verein.lst.de ([213.95.11.211]:35238 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbgGPQAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:00:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8A01E68BEB; Thu, 16 Jul 2020 18:00:22 +0200 (CEST)
Date:   Thu, 16 Jul 2020 18:00:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
Message-ID: <20200716160022.GA29393@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com> <20200715065140.GA22060@lst.de> <4b38a63b-af09-608c-c4fa-b9e484ebe6bc@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b38a63b-af09-608c-c4fa-b9e484ebe6bc@cloud.ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:57:12PM +0200, Guoqing Jiang wrote:
> On 7/15/20 8:51 AM, Christoph Hellwig wrote:
>> On Tue, Jul 14, 2020 at 12:34:45PM -0700, Linus Torvalds wrote:
> I just cloned the tree, seems there is compile issue that you need to 
> resolve.

Fixed and force pushed.
