Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F61F1996
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFHNCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 09:02:49 -0400
Received: from verein.lst.de ([213.95.11.211]:37100 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgFHNCs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:02:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D25368AFE; Mon,  8 Jun 2020 15:02:46 +0200 (CEST)
Date:   Mon, 8 Jun 2020 15:02:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fixes for work.sysctl
Message-ID: <20200608130246.GA22803@lst.de>
References: <20200603055237.677416-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603055237.677416-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping?  Can you pick these up now that the original patches are in
Linus' tree?

On Wed, Jun 03, 2020 at 07:52:33AM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> a bunch of fixes for the sysctl kernel pointer conversion against your
> work.sysctl branch.  Only the first one is a real behavior fix, the rest
> just removes left over __user annotations.
---end quoted text---
