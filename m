Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02CA47C397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 17:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbhLUQPr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 11:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhLUQPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:15:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 08:15:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id m15so12734556pgu.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bklEpDHobgqWBX7dc+qF5nBZ2lZ1g9sxoEpMzCTaqpU=;
        b=McaPtxoGJM4xsoEevOy8RsHXvjAGEHiwAOHZplz+egf79MvEb/g9MUmc2UNQaTddre
         QlLBreI2hQfVVqJ6UaJPDHJQXOUBNYd+SkJfkmv7COk6fXtcMoaqjoDLzjkcmePV/vGC
         WBXOmfsITGw5sEaXCBDIwirunvlEUZTWDzAJX07vMpWc8BH9F0cGTOP/NkJ/fc6iQJ2w
         Ay1ACLgnE6GkSD5SFaW37KxqjQBboAGT4yfOETXQEQd9nOhj9dGTGcYllbA3u3bQYEGB
         AEPq5jR0gaDbpO94NmvOknmav260I3/d7jRpJh1qWKz2i0Ar+CIYKbnv65hQLTWHefjb
         iEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=bklEpDHobgqWBX7dc+qF5nBZ2lZ1g9sxoEpMzCTaqpU=;
        b=PPDbMyr8zrnf76rXtcXnIHnDppKCZGfxrPVulxMYMlDUOLNCk27Seda5naTL2q34mV
         naKg+B21V7pDbmjwIvT1S/4yiVXh/xGewWKe0QPqjxnTQg55PQyjuTMPjlW9w/qkwY7g
         PSZ30Wv2y/LE8/DwpXw1sB4FOCN8XxibxeUQPUBz3PVPPVvpylPOZftJ55riLGFuMP7S
         Hgd7TX9JUWkTCV5dHQLf1hfulaj+Xpsg5Z+vz1amiZpajp9Ps5T/kHKCfc3HMzJnLXGl
         BD0mvfrKTcumDyLFTdsqfV3akQXQquWpiMCbG7BlaTeShhu9D3uJLRrBkf8OZoDAhT4W
         XWiQ==
X-Gm-Message-State: AOAM530rNLZrxTIS3OxadPkmR0pRfsPhy2Goe6hZYCCztIuunYg0mZfr
        gKV+cSAWCArMK7L7yFXYX23Z9LoFks1chb6qwJM=
X-Google-Smtp-Source: ABdhPJzp0npDuTcj+ShLpZtDhWt87/PsEcQhVB48GzUbSBEOezdBtCzfsI9mZQpX+rMAtvXy0mwjyWSzturJxxtSvPw=
X-Received: by 2002:a63:745d:: with SMTP id e29mr3542920pgn.252.1640103345873;
 Tue, 21 Dec 2021 08:15:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8705:0:0:0:0 with HTTP; Tue, 21 Dec 2021 08:15:45
 -0800 (PST)
Reply-To: jesspayne72@gmail.com
From:   Jess Payne <joeladamu2@gmail.com>
Date:   Tue, 21 Dec 2021 08:15:45 -0800
Message-ID: <CAO_K9dhB9VmYSLF4WzWjN+A81admF7-Mj=NLCTXRid+aSYHJAA@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5YqpIC8gSSBuZWVkIHlvdXIgYXNzaXN0YW5jZQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5oiR5piv5p2w6KW/5L2p5oGp5Lit5aOr5aSr5Lq644CCDQoNCuWcqOe+juWbvemZhuWGm+eahOWG
m+S6i+mDqOmXqOOAgue+juWbve+8jOS4gOWQjeS4reWjq++8jDMyIOWyge+8jOaIkeWNlei6q++8
jOadpeiHque+juWbveeUsOe6s+ilv+W3nuWFi+WIqeWkq+WFsO+8jOebruWJjempu+aJjuWcqOWI
qeavlOS6muePreWKoOilv++8jOS4juaBkOaAluS4u+S5ieS9nOaImOOAguaIkeeahOWNleS9jeaY
r+esrDTmiqTnkIbpmJ/nrKw3ODLml4Xkv53pmpzokKXjgIINCg0K5oiR5piv5LiA5Liq5YWF5ruh
54ix5b+D44CB6K+a5a6e5ZKM5rex5oOF55qE5Lq677yM5YW35pyJ6Imv5aW955qE5bm96buY5oSf
77yM5oiR5Zac5qyi57uT6K+G5paw5pyL5Y+L5bm25LqG6Kej5LuW5Lus55qE55Sf5rS75pa55byP
77yM5oiR5Zac5qyi55yL5Yiw5aSn5rW355qE5rOi5rWq5ZKM5bGx6ISJ55qE576O5Li95Lul5Y+K
5aSn6Ieq54S25omA5oul5pyJ55qE5LiA5YiH5o+Q5L6b44CC5b6I6auY5YW06IO95pu05aSa5Zyw
5LqG6Kej5oKo77yM5oiR6K6k5Li65oiR5Lus5Y+v5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L
6LCK44CCDQoNCuaIkeS4gOebtOW+iOS4jeW8gOW/g++8jOWboOS4uui/meS6m+W5tOadpeeUn+a0
u+WvueaIkeS4jeWFrOW5s++8m+aIkeWkseWOu+S6hueItuavje+8jOmCo+W5tOaIkSAyMSDlsoHj
gILmiJHniLbkurLlj6sgUGF0cmljZSBQYXluZe+8jOaIkeavjeS6suWPqyBNYXJ5DQpQYXluZeOA
guayoeacieS6uuW4ruWKqeaIke+8jOS9huW+iOmrmOWFtOaIkee7iOS6juWcqOe+juWGm+S4reaJ
vuWIsOS6huiHquW3seOAgg0KDQrmiJHnu5PlqZrnlJ/kuoblranlrZDvvIzkvYbku5bmrbvkuobv
vIzkuI3kuYXmiJHkuIjlpKvlvIDlp4vmrLrpqpfmiJHvvIzmiYDku6XmiJHkuI3lvpfkuI3mlL7l
vIPlqZrlp7vjgIINCg0K5oiR5Lmf5b6I5bm46L+Q77yM5Zyo5oiR55qE5Zu95a62576O5Zu95ZKM
5Yip5q+U5Lqa54+t5Yqg6KW/6L+Z6YeM5oul5pyJ5oiR55Sf5rS75Lit5omA6ZyA55qE5LiA5YiH
77yM5L2G5rKh5pyJ5Lq65Li65oiR5o+Q5L6b5bu66K6u44CC5oiR6ZyA6KaB5LiA5Liq6K+a5a6e
55qE5Lq65p2l5L+h5Lu777yM5LuW5Lmf5Lya5bCx5aaC5L2V5oqV6LWE5ZCR5oiR5o+Q5L6b5bu6
6K6u44CC5Zug5Li65oiR5piv5oiR54i25q+N5Zyo5LuW5Lus5Y675LiW5YmN55Sf5LiL55qE5ZSv
5LiA5aWz5a2p44CCDQoNCuaIkeS4jeiupOivhuS9oOacrOS6uu+8jOS9huaIkeiupOS4uuacieS4
gOS4quWAvOW+l+S/oei1lueahOWlveS6uu+8jOS7luWPr+S7peW7uueri+ecn+ato+eahOS/oeS7
u+WSjOiJr+WlveeahOWVhuS4muWPi+iwiu+8jOWmguaenOS9oOecn+eahOacieS4gOS4quivmuWu
nueahOWQjeWtl++8jOaIkeS5n+acieS4gOS6m+S4nOilv+imgeWSjOS9oOWIhuS6q+ebuOS/oeOA
guWcqOS9oOi6q+S4iu+8jOWboOS4uuaIkemcgOimgeS9oOeahOW4ruWKqeOAguaIkeaLpeacieaI
keWcqOWIqeavlOS6muePreWKoOilv+i/memHjOi1muWIsOeahOaAu+mine+8iDQ3MA0K5LiH576O
5YWD77yJ44CC5oiR5Lya5Zyo5LiL5LiA5bCB55S15a2Q6YKu5Lu25Lit5ZGK6K+J5L2g5oiR5piv
5aaC5L2V5YGa5Yiw55qE77yM5LiN6KaB5oOK5oWM77yM5LuW5Lus5piv5peg6aOO6Zmp55qE77yM
5oiR6L+Y5Zyo5LiOIFJlZA0K5pyJ6IGU57O755qE5Lq66YGT5Li75LmJ5Yy755Sf55qE5biu5Yqp
5LiL5bCG6L+Z56yU6ZKx5a2Y5YWl5LqG6ZO26KGM44CC5oiR5biM5pyb5oKo5bCG6Ieq5bex5L2c
5Li65oiR55qE5Y+X55uK5Lq65p2l5o6l5pS25Z+66YeR5bm25Zyo5oiR5Zyo6L+Z6YeM5a6M5oiQ
5ZCO56Gu5L+d5a6D55qE5a6J5YWo5bm26I635b6X5oiR55qE5Yab5LqL6YCa6KGM6K+B5Lul5Zyo
5oKo55qE5Zu95a625LiO5oKo5Lya6Z2i77yb5LiN6KaB5a6z5oCV6ZO26KGM5Lya5bCG6LWE6YeR
5a2Y5YKo5ZyoDQpBVE0gVklTQSDljaHkuK3vvIzov5nlr7nmiJHku6zmnaXor7TmmK/lronlhajk
uJTlv6vmjbfnmoTjgIINCg0K56yU6K6wO+aIkeS4jeefpemBk+aIkeS7rOimgeWcqOi/memHjOWR
huWkmuS5he+8jOaIkeeahOWRvei/kO+8jOWboOS4uuaIkeWcqOi/memHjOS4pOasoeeCuOW8ueii
reWHu+S4reW5uOWtmOS4i+adpe+8jOi/meWvvOiHtOaIkeWvu+aJvuS4gOS4quWAvOW+l+S/oei1
lueahOS6uuadpeW4ruWKqeaIkeaOpeaUtuWSjOaKlei1hOWfuumHke+8jOWboOS4uuaIkeWwhuad
peWIsOS9oOS7rOeahOWbveWutuWHuui6q+aKlei1hO+8jOW8gOWni+aWsOeUn+a0u++8jOS4jeWG
jeW9k+WFteOAgg0KDQrlpoLmnpzmgqjmhL/mhI/osKjmhY7lpITnkIbvvIzor7flm57lpI3miJHj
gILmiJHkvJrlkYror4nkvaDkuIvkuIDmraXnmoTmtYHnqIvvvIzlubbnu5nkvaDlj5HpgIHmm7Tl
pJrlhbPkuo7ln7rph5HlrZjlhaXpk7booYznmoTkv6Hmga/jgILku6Xlj4rpk7booYzlsIblpoLk
vZXluK7liqnmiJHku6zpgJrov4cgQVRNIFZJU0ENCkNBUkQg5bCG6LWE6YeR6L2s56e75Yiw5oKo
55qE5Zu95a62L+WcsOWMuuOAguiLpeacieWFtOi2o+ivt+iBlOezu+acrOS6uuOAgg0K
