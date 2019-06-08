Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1F39C86
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFHKzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 06:55:11 -0400
Received: from helmsgagent01.f-secure.com ([193.110.108.21]:39266 "EHLO
        helmsgagent01.f-secure.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbfFHKzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:55:11 -0400
Received: from pps.filterd (helmsgagent01.f-secure.com [127.0.0.1])
        by helmsgagent01.f-secure.com (8.16.0.27/8.16.0.27) with SMTP id x58AjRhh018286;
        Sat, 8 Jun 2019 13:55:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=f-secure.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=msg2048; bh=i/3ksBgyRsQfKYyp3CaQzD0ghbk5MpXhGs9qurwdDNI=;
 b=SqZYcaPU5NPxgFtOp21B2d/jzmx1c1FY39MpKv2b+fwTu/bh755//qncSBS5WPG1UUDl
 lp8YxfesEctffEsWivzCQjEFhNYSPMNotaPKAw64XyH3KTfiUVTnBnXkbxFR8v1Sy/qv
 B+V5zAR3YPDS20EsO1nx4Heyj0O/0t8OlrbspMBC6NpzyqBnbgC8ha15xaUzwtM/7sP0
 y4p7IKMvdQn0qlhkgH7cz+7vpDc3rmTV1lU+3PRvi06An3ZZP48XjExf0k4jjcjDBnIu
 XAmEbuL0VIMnR2eBsOu/wUuQxPCNbDmotMhQwBNJ4Z8mSh1OvMkfbGkBPm35BuPv8AhJ fw== 
Received: from helex02.fi.f-secure.com ([10.190.48.73])
        by helmsgagent01.f-secure.com with ESMTP id 2syykwrew0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 08 Jun 2019 13:55:08 +0300
Received: from drapion.f-secure.com (10.128.132.96) by helex01.FI.F-Secure.com
 (10.190.48.70) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 8 Jun
 2019 13:55:07 +0300
From:   Marko Rauhamaa <marko.rauhamaa@f-secure.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify and pidfd?
References: <87zhmt7bhc.fsf@drapion.f-secure.com>
        <CAOQ4uxjP4kxE6-+UrbHWJ7OWUibixNhTwGWUfdJydYSnRhaxGA@mail.gmail.com>
Date:   Sat, 8 Jun 2019 13:55:07 +0300
In-Reply-To: <CAOQ4uxjP4kxE6-+UrbHWJ7OWUibixNhTwGWUfdJydYSnRhaxGA@mail.gmail.com>
        (Amir Goldstein's message of "Fri, 7 Jun 2019 20:29:27 +0300")
Message-ID: <87r28473ec.fsf@drapion.f-secure.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com>:

> On Fri, Jun 7, 2019 at 5:31 PM Marko Rauhamaa
> <marko.rauhamaa@f-secure.com> wrote:
>> Would it be possible to amend this format with:
>>
>>                __s32 pidfd;
>>
>
> It's possible to report pidfd instead of pid with user opt-in
> (i.e. FAN_REPORT_PIDFD)
>
> If you want to implement this, follow the footsteps of code, test and
> man page for FAN_REPORT_TID.

I hear you.


Marko
