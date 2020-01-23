Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF66214624F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 08:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWHLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 02:11:30 -0500
Received: from [175.24.100.79] ([175.24.100.79]:35860 "EHLO mail.kaowomen.cn"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgAWHLa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:11:30 -0500
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jan 2020 02:11:29 EST
Received: by mail.kaowomen.cn (Postfix, from userid 5002)
        id 6C067E12EA; Thu, 23 Jan 2020 15:04:35 +0800 (CST)
Date:   Thu, 23 Jan 2020 15:04:35 +0800
From:   me@kaowomen.cn
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: remove fs_func struct.
Message-ID: <20200123070435.cjso5yh6nmmhd4gm@kaowomen.cn>
References: <20200117062046.20491-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200122085737.GA2511011@kroah.com>
 <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 06:38:53AM +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
>Hello, Greg.
>
>Thank you for the quick reply.
>
>> Also the patch does not apply to the linux-next tree at all, so I can't take it.
>The patch I sent was based on the master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/”
>and its tag was v5.5-rc6.
>
>> Also the patch does not apply to the linux-next tree at all, so I can't take it.  Please rebase and resend.
>I will send a new patch based on the latest master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git”.
>
>
>By the way, could you answer below questions for my sending patches in future?
>1. Which repository and branch should be based when creating a new patch?
>2. How do I inform you about a base on which I create a patch?
If you like you can add [PATCH -next] to patch title before send it. :)
BR,
>
>--
>Best regards,
>Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
