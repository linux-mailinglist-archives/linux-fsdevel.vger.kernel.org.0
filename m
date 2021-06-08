Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312AD39F4E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhFHL1z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 8 Jun 2021 07:27:55 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:43868 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFHL1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:27:54 -0400
X-Greylist: delayed 333 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 07:27:54 EDT
Received: from SZ11126892 (unknown [58.251.74.232])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id 537AEAC0510;
        Tue,  8 Jun 2021 19:20:27 +0800 (CST)
From:   <changfengnan@vivo.com>
To:     "'Miklos Szeredi'" <miklos@szeredi.hu>
Cc:     <linux-fsdevel@vger.kernel.org>
References: <000301d74329$149c0b90$3dd422b0$@vivo.com> <000d01d74657$d73590f0$85a0b2d0$@vivo.com> <CAJfpegvGZh1EfYv4=nweKjZO9c36iWGnJCYM3g+=bs0cqAKZMw@mail.gmail.com>
In-Reply-To: <CAJfpegvGZh1EfYv4=nweKjZO9c36iWGnJCYM3g+=bs0cqAKZMw@mail.gmail.com>
Subject: =?UTF-8?Q?=E7=AD=94=E5=A4=8D:_=5BPATCH_v2=5D_fuse:_use_newer_i?=
        =?UTF-8?Q?node_info_when_writeback_cache_i?=
        =?UTF-8?Q?s_enabled?=
Date:   Tue, 8 Jun 2021 19:20:26 +0800
Message-ID: <01ea01d75c58$488b38c0$d9a1aa40$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGYA4P+Cucu6cRWZtXPa9aH8CRwngNqQAxdAkzuYXarWu/Z8A==
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0gYHlZPQx1JQxlLSB5CSBhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6Sww4Hj8IFQ0hCi0cFEop
        IUkwCU9VSlVKTUlISk5KSUlMTEhOVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBSUhPTDcG
X-HM-Tid: 0a79eb5a321cb039kuuu537aeac0510
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos:
	Any progress now? looking forward to your comments.

Thanks.

-----邮件原件-----
发件人: Miklos Szeredi <miklos@szeredi.hu> 
发送时间: 2021年5月12日 20:34
收件人: changfengnan@vivo.com
抄送: linux-fsdevel@vger.kernel.org
主题: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled

On Tue, May 11, 2021 at 1:21 PM <changfengnan@vivo.com> wrote:
>
> Hi Miklos：
>
> Did you get a chance to review this patch? looking forward to your comments.

Hi,

The patch looks correct, but this is a complex issue and I want to make sure I understand it fully before applying.

I've not forgotten about it, it's queued for review.

Thanks,
Miklos


