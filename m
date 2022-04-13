Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EDE4FEBE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiDMAUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 20:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiDMAUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 20:20:11 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 17:17:50 PDT
Received: from cmx-torrgo001.bell.net (mta-tor-001.bell.net [209.71.212.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE86113D7D;
        Tue, 12 Apr 2022 17:17:50 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [69.156.160.174]
X-RG-Env-Sender: nick.steeves@bell.net
X-RG-Rigid: 624AF58700E129A7
X-CM-Envelope: MS4xfMobgET0KJEPEy2rz+iImhfnpIh7TGu5qIG8IJ8tylJDUtj79/i41IApO8fQ6BJHy2zpATKD1qgVquPGS2jtTH9RYS9gFGuksIQN38J5OBGRFJTSjUMX
 8GADK057e0F3i+e7MWgFH6nDiyME/cQk80iJ66jGrnArgdcU2v+ow09HEy0sgdN/3N+knZI/Lh0wMMDNTW5cOiKd0CZzKeG5HF/JS60kUiNDy/wDm347zGlA
 I36G3RhYzBelek6anN1W/E+eCGa6sGkwge9Z+qNRjslxCDUsj4Ca08GNhxznpYs//g22LDhsoC9/HOVYRgYAzwFCV34aBrdQQhmYL9qhk4E7LfyqaLxj/SLX
 vczOHF2Fd8hKoW2IOG6HvSmoKZ8ww6hEQvRYnsN6aFCWRQst3NNKcQ+DibEr5nZFQH58prUzjwbhp8sMz3+w+thUCdo4DnS7AT79JpWQkzPqeSBBmDgmUOQk
 UXf/4rwU1UwhFG7wH07qXokX1hlF1uSuLOvAT5eHY4eJuEuK0/x2dP//LnCcCEzpHt0SfRI0MZRHif3lAJCbcIrTgsp+0VwQRhx7ya5BEH7E85wD4ftJONCE
 v7Z7GFNDXQnCELwP0zc86AtTfLmwlEECOemGo7GK6fxOzu4cjwUKzsNapcUgJAOP3jKQOxA1eDQGzQz2W9CeOvBfIwoiZoKUuR4WP0G+NVPQReykaGiY7uA1
 GHepaPB99a8ip7xAvFNbX08OWihABKOiPXGTkWR72zh8lffBd1fytYUx0WUdGyodroxIUD5RyHxiAlFNqx/ClksiXDYHuLePfGHk7fgtJ491vbInIaiVCHlE
 WoqOf0lX+vAtmYZ0WMWyV0QOdvgKXAhV20tzeIcT62SiT+UBECpK+Wl4zWA0DaiVpjAsdtqs7wFHBpDWw1VNm5/RwHPg9Uvch09UkiJan8dn70MkWY6yBGcs
 IBSslcb8RrjcWiDWCkF806JELk2u31nIUKADP8yGtM502rl1MX1ZhtY6h5MbnftMqrUeaBtuitezcWkkdZw1cA00bmUCwcm6QEtuQn3upk4Ivcv0R1tvWkWc
 gddCbzW66cofJ+Sv3i28pES85JHdkDERZzLLr8ioP8FazDkB67tRHI23B95LYAudAPg4PjHsz/T8Hg==
X-CM-Analysis: v=2.4 cv=B8zabMhM c=1 sm=1 tr=0 ts=6256163a
 a=MIeb/1XuSZkfF0zOzarnVA==:117 a=MIeb/1XuSZkfF0zOzarnVA==:17
 a=z0gMJWrwH1QA:10 a=lAgNKBcoAAAA:8 a=VwQbUJbxAAAA:8 a=DbH0gPOPAAAA:8
 a=7mOBRU54AAAA:8 a=fxJcL_dCAAAA:8 a=44LDQt12AAAA:8 a=ZC48hzh6CcCYWVy3ZBUA:9
 a=wU2KtiTIgF-na1uTuREA:9 a=FfaGCDsud1wA:10 a=drE6d5tx1tjNRBs8zHOc:22
 a=AjGcO6oz07-iQ99wixmX:22 a=amFcwBvv0bFiKrp1vszQ:22 a=wa9RWnbW_A1YIeRBVszw:22
 a=Sbs2_LdxfKMdlVWN_trs:22
Received: from DigitalMercury.freeddns.org (69.156.160.174) by cmx-torrgo001.bell.net (5.8.807) (authenticated as nick.steeves@bell.net)
        id 624AF58700E129A7; Tue, 12 Apr 2022 20:15:54 -0400
Received: by DigitalMercury.freeddns.org (Postfix, from userid 1000)
        id 7FD77C41A95; Tue, 12 Apr 2022 20:15:51 -0400 (EDT)
From:   Nicholas D Steeves <sten@debian.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
In-Reply-To: <3ab10248-be14-d161-14e6-bf19ac8cd998@leemhuis.info>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
 <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
 <20220408145222.GR15609@twin.jikos.cz> <YlBa/Rc0lvJCm5Rr@debian9.Home>
 <74e4cc73-f16d-3e79-9927-1de3beea4a11@leemhuis.info>
 <MN2PR20MB2512CEFB95106D91FD9F1717D2E89@MN2PR20MB2512.namprd20.prod.outlook.com>
 <3ab10248-be14-d161-14e6-bf19ac8cd998@leemhuis.info>
Date:   Tue, 12 Apr 2022 20:15:47 -0400
Message-ID: <87r161zvm4.fsf@DigitalMercury.freeddns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Bruno,

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 09.04.22 19:12, Bruno Damasceno Freire wrote:
>> On 08.04.22 04:50, Thorsten Leemhuis wrote:
>>> On 08.04.22 17:55, Filipe Manana wrote:
>>>> On Fri, Apr 08, 2022 at 04:52:22PM +0200, David Sterba wrote:
>>>>> On Fri, Apr 08, 2022 at 12:32:20PM +0200, Thorsten Leemhuis wrote:
>>> Bruno, under these circumstances I'd say you need to bisect this to get
>>> us closer to the root of the problem (and a fix for it). Sadly that how
>>> it is sometimes, as briefly explained here:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/Documentation/admin-guide/reporting-regressions.rst#n140
>>=20
>> Ok Thorsten.
>>=20
>> It's not sad at all: I had a great time researching this regression and
>> gained a lot of knowledge while doing so. The problem is that I am just a
>> simple user at its limits here and additional bisection is probably beyo=
nd my
>> abilities.
>
> Maybe, but I think you underestimate yourself here. Give it a try, it's
> not that hard once you figured out how to build and install a vanilla
> kernel (which you did already afaics; and if not: it's not that hard and
> you learn new stuff, too) and have some test case to check if the
> problem is there or now (which you already have afaics).
>

I also think it's something you can manage :-)

Something like:

1. Use the .config from /boot/config-ubuntu_5.14.x
2. git bisect start
3. git bisect good v5.14 (7d2a07b)
4. git bisect bad v5.15 (8bb7eca)
5. Open a guide like these ones on another device, or print it out:
  https://www.metaltoad.com/blog/beginners-guide-git-bisect-process-elimina=
tion
  https://wiki.gentoo.org/wiki/Kernel_git-bisect
  https://wiki.ubuntu.com/Kernel/KernelBisection
  https://ldpreload.com/blog/git-bisect-run ("Finding a kernel
  regression in half an hour with git bisect run")
6. make oldconfig
7. make bindeb-pkg
8. Deb packages are in ../
9. Install, reboot, run tests, confirm logs, iterate

Thank you for running these tests.  By chance, would you have time to
compare 5.10.x to 5.15.x, or have you already compared them?  I'm
always the most curious about how the latest LTS kernel compares to
latest_LTS-1 ;-)

Regards,
Nicholas

P.S. I'm sure you'll be able to find someone on IRC who'd be willing to
help you, should any help be necessary!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmJWFjQQHHN0ZW5AZGVi
aWFuLm9yZwAKCRBaiDBHX30QYRNWEACk2QT/FbL/b4WUYI6gl7xHgwMk82cU/Zpn
dWRxvQXujZxWcShgdw3aji9nCt0vIWxaAMYh47ox9T0X6qbo4EirFTUmzOGjf9JM
Pu08CyV+qqIB28itWtRvJTlg+5SPxENMFE7/vIVVcx13WxHQTpM7qtdsesqLBLYK
fguEeow5qME57dmbwcF5Xkgn6WORq796/SkTtzRKh4H6Fz17Svpz2twD/TDF1Zmj
wnCYP00SrFKfdBsUO2dYexuAHTUh5ORXQW4ZuB6K9aCUKZpgJK0/c2xNVClulNfq
Td6LMtN35HyLez2VRnzfawbuQIQtm+OTviwAzehV8xqfsGTzeWbaq2k5SoQ3vdg8
XCDNz/c5C+5ni4XVp706FpiIP4oMUcTOq/kr0e4+mwblVi4sAX1WLlTols6xYrr3
luHkbIeqg5bfiwx6Z7lr0c979caHnV0XfnoWKEsgjnuYnpRK9UzPIua5Rf/PT8ZW
JgF1Y/+8sNvutjx0vpSMT2oyX0kau97wNUmPCap9G+Mw7F/MEH57tndTdb8xizHO
4pS55RSVLdE3ILpsv4t76NmC5HCYvwBpnYQu1+EIqyfAESBMuuyZVrYQNJxtIAbV
ltp81CTzIf8aJqL+sjODXbRrg+oR+QBsz5Nz+3vynu9lsBGJVrB9rvpcE7q9Io0l
iGY0rZsWcg==
=YG5y
-----END PGP SIGNATURE-----
--=-=-=--
