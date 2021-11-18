Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17666456107
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhKRRCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 12:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhKRRCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:02:34 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8812FC06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 08:59:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y7so5835766plp.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LEc7NFqr3FKAIjT7OCYf7cUapdW8bqBPdFrn2WI98Kc=;
        b=kXj4zLUeLgOQ6T8YUsxCzDVALiScqc/nGaIsO33GPoj4gdXKBmPemvZO736L85Sf3B
         T6+NVchynMOh7CD+USfO5oLzGvNoJipOvt2ud2wKMQ3bIILu0y/OFCX/KQFKwgty7j0o
         trN6R5nr3P5htAyJB64pWrF+/MEt9qJzjfYPQo/CfYorzSqLrIj/xynBT1zgG0Xmis4v
         t3zGI1lD9UlmEDWGDxT3X8LqxkaMkZyVvwN4gd2UC+cFbU6K2fnJffQuctWbkRoT+F7o
         sKVRzuk+lPb551ZcKXxGANDNpw3+5/FHAK9DWvQNJFtZQ4bkZkzfTgbzvukfhZs28X+d
         ySbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LEc7NFqr3FKAIjT7OCYf7cUapdW8bqBPdFrn2WI98Kc=;
        b=xcn09kOscMDZ0hARo2Loe4zcf4WC59a1gfFLySbe//eq7LW6on/fL19F+GR3pL6546
         4L/4bL+Kak6vJ5GKcnSLmhClQQqzk2R5n8FbltVrERO9fHa6bYtGD4G9kevF/V9Jrorf
         lEhnhxa5Keb66GEDD84SdRl32WOqaXPUPdWdH1aroOpx+CHpgDRdohKt4CVdcCAA49um
         ZO6QJliK5m037IGYx8lGMnpYZgBktks8/DqCqinfsq2jQCkW5U+PQYIodGYOcBajIcrA
         /+vJy2MqUZ4MedjMDt+hWZbc4dItqgc8MXnSpDVk8Sl3nce/BlD56JLsu+pC2ntq/EmC
         2uUQ==
X-Gm-Message-State: AOAM533WuN+kk5lWPXJoyom37A7CdW7WRYnvE7uIcq4MU1uBVjs/4aRi
        tlOzlHTW5g5HUeB/awtLD0LsdaRCWv3nVX0KNAY=
X-Google-Smtp-Source: ABdhPJwy+KD/ND05drCkWlAwEiT8rhQUI++dRw7/ude9WadAUs+b+hkENpY0TYvp5NdVu176Ryq4vfBMRnO6inMWyNs=
X-Received: by 2002:a17:90a:e297:: with SMTP id d23mr12178447pjz.131.1637254774036;
 Thu, 18 Nov 2021 08:59:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a20:3288:b0:5d:5519:fb13 with HTTP; Thu, 18 Nov 2021
 08:59:33 -0800 (PST)
Reply-To: liampayen50@gmail.com
From:   liam payen <mousandiaye411@gmail.com>
Date:   Thu, 18 Nov 2021 08:59:33 -0800
Message-ID: <CAK_EP0R+WBEofxNd1g4hpbCO4Gd3zcQ=0kruULzKsZMkOFUPgQ@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

5oiR5biM5pyb5L2g6IO955CG6Kej6L+Z5p2h5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5Yip55So
57+76K+R57uZ5L2g5YaZ5L+h44CCDQoNCuaIkeaYr+WIqeS6muWnhsK35L2p5oGp5Lit5aOr5aSr
5Lq644CCDQrlnKjnvo7lm73pmYblhpvnmoTlhpvkuovpg6jpl6jjgILnvo7lm73vvIzkuIDlkI3k
uK3lo6vvvIwzMiDlsoHvvIzmiJHljZXouqvvvIzmnaXoh6rnvo7lm73nlLDnurPopb/lt57lhYvl
iKnlpKvlhbDvvIznm67liY3pqbvmiY7lnKjlj5nliKnkuprvvIzkuI7mgZDmgJbkuLvkuYnkvZzm
iJjjgILmiJHnmoTljZXkvY3mmK/nrKw05oqk55CG6Zif56ysNzgy5peF5L+d6Zqc6JCl44CCDQoN
CuaIkeaYr+S4gOS4quWFhea7oeeIseW/g+OAgeivmuWunuWSjOa3seaDheeahOS6uu+8jOWFt+ac
ieiJr+WlveeahOW5vem7mOaEn++8jOaIkeWWnOasoue7k+ivhuaWsOaci+WPi+W5tuS6huino+S7
luS7rOeahOeUn+a0u+aWueW8j++8jOaIkeWWnOasoueci+WIsOWkp+a1t+eahOazoua1quWSjOWx
seiEieeahOe+juS4veS7peWPiuWkp+iHqueEtuaJgOaLpeacieeahOS4gOWIh+aPkOS+m+OAguW+
iOmrmOWFtOiDveabtOWkmuWcsOS6huino+aCqO+8jOaIkeiupOS4uuaIkeS7rOWPr+S7peW7uuer
i+iJr+WlveeahOWVhuS4muWPi+iwiuOAgg0KDQrmiJHkuIDnm7TlvojkuI3lvIDlv4PvvIzlm6Dk
uLrov5nkupvlubTmnaXnlJ/mtLvlr7nmiJHkuI3lhazlubPvvJvmiJHlpLHljrvkuobniLbmr43v
vIzpgqPlubTmiJEgMjENCuWygeOAguaIkeeItuS6suWPq+S5lOWwlMK35L2p5oGp77yM5q+N5Lqy
5Y+r546b5Li9wrfkvanmganjgILmsqHmnInkurrluK7liqnmiJHvvIzkvYblvojpq5jlhbTmiJHn
u4jkuo7lnKjnvo7lhpvkuK3mib7liLDkuoboh6rlt7HjgIINCg0K5oiR57uT5ama55Sf5LqG5a2p
5a2Q77yM5L2G5LuW5q275LqG77yM5LiN5LmF5oiR5LiI5aSr5byA5aeL5qy66aqX5oiR77yM5omA
5Lul5oiR5LiN5b6X5LiN5pS+5byD5ama5ae744CCDQoNCuaIkeS5n+W+iOW5uOi/kO+8jOWcqOaI
keeahOWbveWutuOAgee+juWbveWSjOWPmeWIqeS6mui/memHjO+8jOaLpeacieaIkeeUn+a0u+S4
remcgOimgeeahOS4gOWIh++8jOS9huayoeacieS6uue7meaIkeW7uuiuruOAguaIkemcgOimgeS4
gOS4quivmuWunueahOS6uuadpeS/oeS7u++8jOS7luS5n+S8muWwseWmguS9leaKlei1hOWQkeaI
keaPkOS+m+W7uuiuruOAguWboOS4uuaIkeaYr+aIkeeItuavjeWcqOS7luS7rOWOu+S4luWJjeeU
n+S4i+eahOWUr+S4gOWls+WtqeOAgg0KDQrmiJHkuI3orqTor4bkvaDmnKzkurrvvIzkvYbmiJHo
rqTkuLrmnInkuIDkuKrlgLzlvpfkv6HotZbnmoTlpb3kurrvvIzku5blj6/ku6Xlu7rnq4vnnJ/m
raPnmoTkv6Hku7vlkozoia/lpb3nmoTllYbkuJrlj4vosIrvvIzlpoLmnpzkvaDnnJ/nmoTmnInk
uIDkuKror5rlrp7nmoTlkI3lrZfvvIzmiJHkuZ/mnInkuIDkupvkuJzopb/opoHlkozkvaDliIbk
uqvnm7jkv6HjgILlnKjkvaDouqvkuIrvvIzlm6DkuLrmiJHpnIDopoHkvaDnmoTluK7liqnjgILm
iJHmi6XmnInmiJHlnKjlj5nliKnkuprov5nph4zotZrliLDnmoTmgLvpop3vvIg1NTANCuS4h+e+
juWFg++8ieOAguaIkeS8muWcqOS4i+S4gOWwgeeUteWtkOmCruS7tuS4reWRiuivieS9oOaIkeaY
r+WmguS9leWBmuWIsOeahO+8jOS4jeimgeaDiuaFjO+8jOS7luS7rOaYr+aXoOmjjumZqeeahO+8
jOaIkei/mOWcqOS4jiBSZWQNCuacieiBlOezu+eahOS6uumBk+S4u+S5ieWMu+eUn+eahOW4ruWK
qeS4i+Wwhui/meeslOmSseWtmOWFpeS6humTtuihjOOAguaIkeW4jOacm+aCqOWwhuiHquW3seS9
nOS4uuaIkeeahOWPl+ebiuS6uuadpeaOpeaUtuWfuumHkeW5tuWcqOaIkeWcqOi/memHjOWujOaI
kOWQjuehruS/neWug+eahOWuieWFqOW5tuiOt+W+l+aIkeeahOWGm+S6i+mAmuihjOivgeS7peWc
qOaCqOeahOWbveWutuS4juaCqOS8mumdou+8m+S4jeimgeWus+aAlemTtuihjOS8muWwhui1hOmH
keWtmOWCqOWcqA0KQVRNIFZJU0Eg5Y2h5Lit77yM6L+Z5a+55oiR5Lus5p2l6K+05piv5a6J5YWo
5LiU5b+r5o2355qE44CCDQoNCueslOiusDvmiJHkuI3nn6XpgZPmiJHku6zopoHlnKjov5nph4zl
kYblpJrkuYXvvIzmiJHnmoTlkb3ov5DvvIzlm6DkuLrmiJHlnKjov5nph4zkuKTmrKHngrjlvLno
oq3lh7vkuK3lubjlrZjkuIvmnaXvvIzov5nlr7zoh7TmiJHlr7vmib7kuIDkuKrlgLzlvpfkv6Ho
tZbnmoTkurrmnaXluK7liqnmiJHmjqXmlLblkozmipXotYTln7rph5HvvIzlm6DkuLrmiJHlsIbm
naXliLDkvaDku6znmoTlm73lrrblh7rouqvmipXotYTvvIzlvIDlp4vmlrDnlJ/mtLvvvIzkuI3l
ho3lvZPlhbXjgIINCg0K5aaC5p6c5oKo5oS/5oSP6LCo5oWO5aSE55CG77yM6K+35Zue5aSN5oiR
44CC5oiR5Lya5ZGK6K+J5L2g5LiL5LiA5q2l55qE5rWB56iL77yM5bm257uZ5L2g5Y+R6YCB5pu0
5aSa5YWz5LqO5Z+66YeR5a2Y5YWl6ZO26KGM55qE5L+h5oGv44CC5Lul5Y+K6ZO26KGM5bCG5aaC
5L2V5biu5Yqp5oiR5Lus6YCa6L+HIEFUTSBWSVNBDQpDQVJEIOWwhui1hOmHkei9rOenu+WIsOaC
qOeahOWbveWuti/lnLDljLrjgILlpoLmnpzkvaDmnInlhbTotqPvvIzor7fkuI7miJHogZTns7vj
gIINCg==
