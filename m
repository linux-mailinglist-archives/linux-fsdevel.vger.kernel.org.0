Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638232C564
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353369AbhCDAU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242792AbhCCQh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:37:56 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F7C0613DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 08:37:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so43454403ejc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpdvJ23q1oid0H28mLrnVIimUayOznJ9U6AdMVzu7XQ=;
        b=Pck6m/m37NKs1t408alxl2zct6EFCZ+SOWmMNjrdC4f1Ho+51EDiONONQhe/48fq2F
         neO+W8oBo97MIVzjpzNg0P3B7SQ2FNVs51j/04W0RrCupaGJnUifTKgs+FnGAU+MAdQu
         N1DmoEjN/QQqTdg5Pn8isQXk3q1MkQIiJDR7216YJ/qLJ2nanz61ynJavQMFJS0HGpf+
         HIijVIYC68IjghLiLQ5h0wnXyr6Xg1gUIS+iEFCBo/EdG2FIwOUpsmHHANeSSfIq97cz
         UekPZZNxpuGW914WoKLYyYU+oPgIClFzdLW6G3sisIqpt3vq6TEbLwIpUcPgeuWqWKDz
         UDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpdvJ23q1oid0H28mLrnVIimUayOznJ9U6AdMVzu7XQ=;
        b=R9B8xVc+pEFBDG0xDV9bCmey7wE//hEr6ZrYDcfBtAwApp72rvruNjkPHXODyC6hDh
         hmjKb/dQTESYAb+0rE1T73hVIRN5wRQdN6G9jTKCxOBs4kZUie5KU/52qO4XL9aLw1T1
         xeuLJqK+nKSiny6iIYeSVBFIjY+tqirYNgviLpp1+MV99zUXP+UAuelG04xCXl3PVT5T
         SwjqHNSh/n3oggWkH1Q9iuiYOTH+fdDw3NWsptYHXzSwEf1mH+DAstqWFrrrdASzVP0J
         df2WIPDxyuzTQ1CmGC9VRWgsf5shR+EZapwiHiu8bbPJeIFAE9tT4+oeHQuOAYZvkNhF
         2H7w==
X-Gm-Message-State: AOAM530TLGTSq3UASiAW1wDIeHe3HU63UJxdsQTdmzXG3gVY83dIFWi+
        cd//A0PFmS8ZslK3Xdliaw1WVppwyp+M5k0GS2cCcg==
X-Google-Smtp-Source: ABdhPJwF8MkpPwcSJx52llkHFBetQmF+xwrNFsW12qXmw2Cm0D8kEhFV+UtaVpaxcf1PT/1KKSg9dx4sc9VzvQ+1Kfo=
X-Received: by 2002:a17:906:c102:: with SMTP id do2mr26650941ejc.305.1614789423964;
 Wed, 03 Mar 2021 08:37:03 -0800 (PST)
MIME-Version: 1.0
References: <1ad49a62-41dd-cdcc-2f8c-b7a2ad67c3b6@huawei.com> <a32dfe3c-8821-77c3-23dd-809b659d2e4f@huawei.com>
In-Reply-To: <a32dfe3c-8821-77c3-23dd-809b659d2e4f@huawei.com>
From:   Gioh Kim <gi-oh.kim@cloud.ionos.com>
Date:   Wed, 3 Mar 2021 17:36:28 +0100
Message-ID: <CAJX1YtboZLrmiNMtRBU8-U5rQNv9GqEPx+TiWyLt0mqqotmksQ@mail.gmail.com>
Subject: Re: can the idle value of /proc/stat decrease?
To:     "xuqiang (M)" <xuqiang36@huawei.com>
Cc:     adobriyan@gmail.com, christian.brauner@ubuntu.com,
        michael.weiss@aisec.fraunhofer.de, sfr@canb.auug.org.au,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        rui.xiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We found the same problem on our production servers.

For example, prometheus-node-exporter reported below message:
daemon.info: Feb  8 17:43:12 ps601b-202
prometheus-node-exporter[2506]: level=3Dwarn ts=3D2021-02-08T17:43:12.052Z
caller=3Dcpu_linux.go:247 collector=3Dcpu msg=3D"CPU Idle counter jumped
backwards, possible hotplug event, resetting CPU stats" cpu=3D78
old_value=3D1.04782328e+06 new_value=3D1.04782178e+06

The idle value was changed from 1.04782328e+06 to 1.04782178e+06.

AND the server rebooted after some minutes.
There is no other error in the log files.
I currently suspect the CPU counter decreasing caused the system reboot.

On Mon, Dec 28, 2020 at 8:57 AM xuqiang (M) <xuqiang36@huawei.com> wrote:
>
> Our recent test shows that the idle value of /proc/stat can decrease.
> Is this an unreported bug? or it has been reported and the solution is
> waiting to get merged.
>
> The results of the two readings from /proc/stat are shown as below, the
> interval between the two readings is 150 ms:
>
> cat /proc/stat
> cpu0 5536 10 14160 4118960 0 0 227128 0 0 0
>
> cat /proc/stat
> cpu0 5536 10 14160 4118959 0 0 227143 0 0 0



--=20
Gioh Kim

Cloud server kernel maintainer
Quality Management (IONOS Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 176 26978962
E-mail: gi-oh.kim@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Dr. Christian B=C3=B6ing, H=C3=BCseyin Dogan, Dr. Martin Endre=C3=
=9F,
Hans-Henning Kettler, Arthur Mai, Matthias Steinberg, Achim Wei=C3=9F
Aufsichtsratsvorsitzender: Markus Kadelke

Member of United Internet

Diese E-Mail kann vertrauliche und/oder gesetzlich gesch=C3=BCtzte
Informationen enthalten. Wenn Sie nicht der bestimmungsgem=C3=A4=C3=9Fe Adr=
essat
sind oder diese E-Mail irrt=C3=BCmlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgem=C3=A4=C3=9Fen Adressaten ist untersagt, diese E-Mail zu
speichern, weiterzuleiten oder ihren Inhalt auf welche Weise auch
immer zu verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
