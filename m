Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8210398
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEABDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 21:03:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54216 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEABDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:03:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLdes-00038y-RE; Wed, 01 May 2019 01:03:39 +0000
Date:   Wed, 1 May 2019 02:03:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH resend] vfs: return EINVAL instead of ENOENT when missing
 source
Message-ID: <20190501010338.GN23075@ZenIV.linux.org.uk>
References: <20190501003535.23426-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501003535.23426-1-jencce.kernel@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 01, 2019 at 08:35:35AM +0800, Murphy Zhou wrote:
> From: Xiong Zhou <jencce.kernel@gmail.com>
> 
> mount(2) with a NULL source device would return ENOENT instead of EINVAL
> after this commit:

See ee948837d7fa in vfs.git#fixes...
