Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB2376351
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhEGKKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 06:10:36 -0400
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:48422 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbhEGKKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 06:10:35 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 06:10:35 EDT
Received: from SZ11126892 (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id C1FA92800F0;
        Fri,  7 May 2021 18:09:34 +0800 (CST)
From:   <changfengnan@vivo.com>
To:     <changfengnan@vivo.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
Date:   Fri, 7 May 2021 18:09:34 +0800
Message-ID: <000301d74329$149c0b90$3dd422b0$@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AddDKQVB5eiByx/4QRyIK4Ppf7Fr0Q==
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk4aHlZDTEsYTB9OGkxNGkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M006FDo4Kz8cMzoxTBofAhcJ
        ChoaCh5VSlVKTUlLSENJSkxOSUpNVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOSlVMT1VJSElZV1kIAVlBQklMNwY+
X-HM-Tid: 0a79464dceb4da03kuwsc1fa92800f0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's been a long time since this patch was sent, any review comments?
Thanks

