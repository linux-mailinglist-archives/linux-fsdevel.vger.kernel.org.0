Return-Path: <linux-fsdevel+bounces-62723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC8B9F192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396103A39BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A272FE595;
	Thu, 25 Sep 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaqPktAi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8212FD1B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802212; cv=none; b=mp+Qn5rPxVcsCzu3wpEdyio5fwVjuRr/lhNDnrmNH3hWsI9vH3Gv3M1B27EHDaQmCTJA4EDaY7uW1vrSW/PFxfr1j2jQM4WCU+AXlaVcfIFzKQVpexh6Td7kApH+Q61gtukwp5x5o6NZM+X/kR/f1uhI1ZyQGN9/fFf2QOjgvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802212; c=relaxed/simple;
	bh=fJg+Wixe2pbT6a6+AsWhbcI0zsxkqLQvXlTvX8HLg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LqpbihoZkTpRRRHQ0yYLuTSvj/7R9zNuxrH3UnCz5Ao82RM+IEzbV0KVktlvTCJGXx8lR4G19D5SyezbnS4Bb3hFTBd6NvNNPrWMZ24wlezqZKki5VnTIPbUEpQ7GTRaJo53TRRUbZUVYydFYWrf2AVGiM3qa0pk9dL1PSaCg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaqPktAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A1CC4CEF0;
	Thu, 25 Sep 2025 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758802212;
	bh=fJg+Wixe2pbT6a6+AsWhbcI0zsxkqLQvXlTvX8HLg1c=;
	h=Date:From:To:Cc:Subject:From;
	b=AaqPktAiKSDoH281Cam7EpxwHgnHZfHMrQOBBOnq8VPBjkW3eDnUaSt8LyruQekgc
	 YuzGldhoWHKMn7uh6tmiRge62klX1vv9j+IQTqjuQYkJImZTzAdEpMMrRPBR4Zp1gQ
	 y/+8n7UWASmgTiHszbdGKyPjSNHslBoegfR2XMHZfVipXhvmeZKo7nPiCyvUQ0Mtyc
	 fCBaU31FeTemqSbUncFwW6vtVzrIEyqwgKn3uqrYJBZ+DzZPBgpg82G640Ncd2TDq1
	 REwc4WZmG1OYH/cOyohMphitQGnIMa00nYpz3VFlH1AIdGWgQSfVjBNYBzJO/S5HnL
	 ctnYrcP0j9zXg==
Date: Thu, 25 Sep 2025 13:10:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: LTP listmount04 failures after "listmount: don't call path_put()
 under namespace semaphore"
Message-ID: <3f916c7a-ae8e-4e38-8006-9dd54b8f3746@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AtzJzu8llHkO1YO8"
Content-Disposition: inline
X-Cookie: Shipping not included.


--AtzJzu8llHkO1YO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm seeing test failures in -next on the LTP listmount04 test which
bisect to 59bfb6681680 (listmount: don't call path_put() under namespace
semaphore) which I can't seem to find on lore.  The test causes a NULL
pointer dereference:

[   39.325361] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000000000b8

=2E..

[   39.585813] Call trace:
[   39.588284]  mnt_ns_release+0x50/0x108 (P)
[   39.592426]  __arm64_sys_listmount+0xc0/0x540
[   39.596831]  invoke_syscall+0x48/0x104
[   39.600620]  el0_svc_common.constprop.0+0x40/0xe0
[   39.605379]  do_el0_svc+0x1c/0x28
[   39.608728]  el0_svc+0x34/0xec
[   39.611811]  el0t_64_sync_handler+0xa0/0xf0
[   39.616051]  el0t_64_sync+0x198/0x19c
[   39.619747] Code: d65f03c0 9102e265 52800022 f98000b1 (885f7ca1)=20
[   39.625913] ---[ end trace 0000000000000000 ]---

Full log:

   https://lava.sirena.org.uk/scheduler/job/1882244#L2944

Bisect log:

# bad: [b5a4da2c459f79a2c87c867398f1c0c315779781] Add linux-next specific f=
iles for 20250924
# good: [69ed2a71d8f82f4304aa52c2c4abf41d1c1f4c7e] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [e609438851928381e39b5393f17156955a84122a] regulator: dt-bindings: =
qcom,sdm845-refgen-regulator: document more platforms
# good: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] regulator: dt-bindings: =
qcom,sdm845-refgen-regulator: document more platforms
# good: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] tas2783A: Add acpi match=
 changes for Intel MTL
# good: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] SPI: Add virtio SPI driv=
er
# good: [ad4728740bd68d74365a43acc25a65339a9b2173] spi: rpc-if: Add resume =
support for RZ/G3E
# good: [46c8b4d2a693eca69a2191436cffa44f489e98c7] ASoC: cs35l41: Fallback =
to reading Subsystem ID property if not ACPI
# good: [e336ab509b43ea601801dfa05b4270023c3ed007] spi: rename SPI_CS_CNT_M=
AX =3D> SPI_DEVICE_CS_CNT_MAX
# good: [878702702dbbd933a5da601c75b8e58eadeec311] spi: ljca: Remove Wenton=
g's e-mail address
# good: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] ASoC: fsl: fsl_qmc_audio=
: Drop struct qmc_dai_chan
# good: [20253f806818e9a1657a832ebcf4141d0a08c02a] spi: atmel-quadspi: Add =
support for sama7d65 QSPI
# good: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] ASoC: soc-dapm: add snd_=
soc_dapm_set_idle_bias()
# good: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] ASoC: da7213: Convert to=
 DEFINE_RUNTIME_DEV_PM_OPS()
# good: [0266f9541038b9b98ddd387132b5bdfe32a304e3] ASoC: codecs: wcd937x: g=
et regmap directly
# good: [0f67557763accbdd56681f17ed5350735198c57b] spi: spi-nxp-fspi: Add O=
CT-DTR mode support
# good: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] spi: spi-qpic-snand: sim=
plify clock handling by using devm_clk_get_enabled()
# good: [abe962346ef420998d47ba1c2fe591582f69e92e] regulator: Fix MAX77838 =
selection
# good: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] spi: mt65xx: add dual an=
d quad mode for standard spi device
# good: [8d7de4a014f589c1776959f7fdadbf7b12045aac] ASoC: dt-bindings: asahi=
-kasei,ak4458: Reference common DAI properties
# good: [88d0d17192c5a850dc07bb38035b69c4cefde270] ASoC: dt-bindings: add b=
indings for pm4125 audio codec
# good: [8b84d712ad849172f6bbcad57534b284d942b0b5] regulator: spacemit: sup=
port SpacemiT P1 regulators
# good: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] regulator: max77838: add=
 max77838 regulator driver
# good: [4d906371d1f9fc9ce47b2c8f37444680246557bc] nsfs: drop tautological =
ioctl() check
# good: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] nsfs: validate extensibl=
e ioctls
# good: [8b184c34806e5da4d4847fabd3faeff38b47e70a] ASoC: Intel: hda-sdw-bpt=
: set persistent_buffer false
# good: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] spi: amlogic: Fix error =
checking on regmap_write call
# good: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] ASoC: codecs: pcm1754: a=
dd pcm1754 dac driver
# good: [59ba108806516adeaed51a536d55d4f5e9645881] ASoC: dt-bindings: linux=
,spdif: Add "port" node
# good: [30db1b21fa37a2f37c7f4d71864405a05e889833] spi: axi-spi-engine: use=
 adi_axi_pcore_ver_gteq()
# good: [2e0fd4583d0efcdc260e61a22666c8368f505353] rust: regulator: add dev=
m_enable and devm_enable_optional
# good: [6a129b2ca5c533aec89fbeb58470811cc4102642] MAINTAINERS: Add an entr=
y for Amlogic spifc driver
# good: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] spi: cadence-quadspi: Us=
e BIT() macros where possible
# good: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] ASoC: cs-amp-lib-test: A=
dd test for getting cal data from HP EFI
# good: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] ASoC: codecs: tlv320dac3=
3: Convert to use gpiod api
# good: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] regulator: dt-bindings: =
rpi-panel: Split 7" Raspberry Pi 720x1280 v2 binding
# good: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] ASoC: Intel: bytcr_rt565=
1: Fix invalid quirk input mapping
# good: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] spi: dt-bindings: samsun=
g: Drop S3C2443
# good: [7d083666123a425ba9f81dff1a52955b1f226540] ASoC: renesas: rz-ssi: U=
se guard() for spin locks
# good: [b497e1a1a2b10c4ddb28064fba229365ae03311a] regulator: pf530x: Add a=
 driver for the NXP PF5300 Regulator
# good: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] ASoC: replace use of sys=
tem_unbound_wq with system_dfl_wq
# good: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] ASoC: dt-bindings: wlf,w=
m8960: Document routing strings (pin names)
# good: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] ASoC: dt-bindings: qcom,=
lpass-va-macro: Update bindings for clocks to support ADSP
# good: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] ASoC: cs42l43: Shutdown =
jack detection on suspend
# good: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] spi: spi-fsl-dspi: Repor=
t FIFO overflows as errors
# good: [94b39cb3ad6db935b585988b36378884199cd5fc] spi: mxs: fix "transfere=
d"->"transferred"
# good: [06dd3eda0e958cdae48ca755eb5047484f678d78] Merge branch 'vfs-6.18.r=
ust' into vfs.all
# good: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] ASoC: codecs: lpass-wsa-=
macro: add Codev version 2.9
# good: [ce57b718006a069226b5e5d3afe7969acd59154e] ASoC: Intel: avs: ssm456=
7: Adjust platform name
# good: [3279052eab235bfb7130b1fabc74029c2260ed8d] ASoC: SOF: ipc4-topology=
: Fix a less than zero check on a u32
# good: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] ASoC: qcom: audioreach: =
convert to cpu endainess type before accessing
# good: [9d35d068fb138160709e04e3ee97fe29a6f8615b] regulator: scmi: Use int=
 type to store negative error codes
# good: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] ASoC: soc-dapm: rename s=
nd_soc_kcontrol_component() to snd_soc_kcontrol_to_component()
# good: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] ASoC: sof: ipc4-topology=
: Add support to sched_domain attribute
# good: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] ASoC: SOF: Intel: only d=
etect codecs when HDA DSP probe
# good: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] ASoC: SOF: sof-client: I=
ntroduce sof_client_dev_entry structure
# good: [f7c41911ad744177d8289820f01009dc93d8f91c] ASoC: SOF: ipc4-topology=
: Add support for float sample type
# good: [d57d27171c92e9049d5301785fb38de127b28fbf] ASoC: SOF: sof-client-pr=
obes: Add available points_info(), IPC4 only
# good: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] ASoC: doc: Internally li=
nk to Writing an ALSA Driver docs
# good: [c42e36a488c7e01f833fc9f4814f735b66b2d494] spi: Drop dev_pm_domain_=
detach() call
# good: [a37280daa4d583c7212681c49b285de9464a5200] ASoC: Intel: avs: Allow =
i2s test and non-test boards to coexist
# good: [b088b6189a4066b97cef459afd312fd168a76dea] ASoC: mediatek: common: =
Switch to for_each_available_child_of_node_scoped()
# good: [ff9a7857b7848227788f113d6dc6a72e989084e0] spi: rb4xx: use devm for=
 clk_prepare_enable
# good: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] regmap: use int type to =
store negative error codes
# good: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] ASoC: renesas: msiof: st=
art DMAC first
# good: [e2ab5f600bb01d3625d667d97b3eb7538e388336] rust: regulator: use `to=
_result` for error handling
# good: [11f5c5f9e43e9020bae452232983fe98e7abfce0] ASoC: qcom: use int type=
 to store negative error codes
# good: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] ASoC: amd: acp: Remove (=
explicitly) unused header
# good: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] regulator: core: Remove =
redundant ternary operators
# good: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] ASoC: tlv320aic32x4: use=
 dev_err_probe() for regulators
# good: [f840737d1746398c2993be34bfdc80bdc19ecae2] ASoC: SOF: imx: Remove t=
he use of dev_err_probe()
# good: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] ASoC: dt-bindings: Minor=
 whitespace cleanup in example
# good: [96bcb34df55f7fee99795127c796315950c94fed] ASoC: test-component: Us=
e kcalloc() instead of kzalloc()
# good: [c232495d28ca092d0c39b10e35d3d613bd2414ab] ASoC: dt-bindings: omap-=
twl4030: convert to DT schema
# good: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] regulator: consumer.rst:=
 document bulk operations
# good: [27848c082ba0b22850fd9fb7b185c015423dcdc7] spi: s3c64xx: Remove the=
 use of dev_err_probe()
# good: [da9881d00153cc6d3917f6b74144b1d41b58338c] ASoC: qcom: audioreach: =
add support for SMECNS module
# good: [c1dd310f1d76b4b13f1854618087af2513140897] spi: SPISG: Use devm_kca=
lloc() in aml_spisg_clk_init()
# good: [cf65182247761f7993737b710afe8c781699356b] ASoC: codecs: wsa883x: H=
andle shared reset GPIO for WSA883x speakers
# good: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] regulator: bd718x7: Use =
kcalloc() instead of kzalloc()
# good: [2a55135201d5e24b80b7624880ff42eafd8e320c] ASoC: Intel: avs: Stream=
line register-component function names
# good: [daf855f76a1210ceed9541f71ac5dd9be02018a6] ASoC: es8323: enable DAP=
M power widgets for playback DAC
# good: [0056b410355713556d8a10306f82e55b28d33ba8] spi: offload trigger: ad=
i-util-sigma-delta: clean up imports
# good: [90179609efa421b1ccc7d8eafbc078bafb25777c] spi: spl022: use min_t()=
 to improve code
# good: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] spi: remove unneeded 'fa=
st_io' parameter in regmap_config
# good: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] ASoC: es8323: enable DAP=
M power widgets for playback DAC and output
# good: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] regulator: rt5133: Fix s=
pelling mistake "regualtor" -> "regulator"
# good: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] regulator: remove unneed=
ed 'fast_io' parameter in regmap_config
# good: [0e62438e476494a1891a8822b9785bc6e73e9c3f] ASoC: Intel: sst: Remove=
 redundant semicolons
# good: [a46e95c81e3a28926ab1904d9f754fef8318074d] ASoC: wl1273: Remove
# good: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] regmap: Remove superfluo=
us check for !config in __regmap_init()
# good: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] regulator: rt5133: Add R=
T5133 PMIC regulator Support
# good: [9c45f95222beecd6a284fd1284d54dd7a772cf59] spi: spi-qpic-snand: han=
dle 'use_ecc' parameter of qcom_spi_config_cw_read()
# good: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] ASoC: dt-bindings: Conve=
rt brcm,bcm2835-i2s to DT schema
# good: [b832b19318534bb4f1673b24d78037fee339c679] spi: loopback-test: Don'=
t use %pK through printk
# good: [8c02c8353460f8630313aef6810f34e134a3c1ee] ASoC: dt-bindings: realt=
ek,alc5623: convert to DT schema
# good: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] spi: spi-qpic-snand: rem=
ove 'clr*status' members of struct 'qpic_ecc'
# good: [a54ef14188519a0994d0264f701f5771815fa11e] regulator: dt-bindings: =
Clean-up active-semi,act8945a duplication
# good: [2291a2186305faaf8525d57849d8ba12ad63f5e7] MAINTAINERS: Add entry f=
or FourSemi audio amplifiers
# good: [595b7f155b926460a00776cc581e4dcd01220006] ASoC: Intel: avs: Condit=
ional-path support
# good: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] ASoC: soc-component: unp=
ack snd_soc_component_init_bias_level()
# good: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] spi: spi-qpic-snand: avo=
id double assignment in qcom_spi_probe()
# good: [3059067fd3378a5454e7928c08d20bf3ef186760] ASoC: cs48l32: Use PTR_E=
RR_OR_ZERO() to simplify code
# good: [9a200cbdb54349909a42b45379e792e4b39dd223] rust: regulator: impleme=
nt Send and Sync for Regulator<T>
# good: [2d86d2585ab929a143d1e6f8963da1499e33bf13] ASoC: pxa: add GPIOLIB_L=
EGACY dependency
# good: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] regmap: mmio: Add missin=
g MODULE_DESCRIPTION()
# good: [162e23657e5379f07c6404dbfbf4367cb438ea7d] regulator: pf0900: Add P=
MIC PF0900 support
git bisect start 'b5a4da2c459f79a2c87c867398f1c0c315779781' '69ed2a71d8f82f=
4304aa52c2c4abf41d1c1f4c7e' 'e609438851928381e39b5393f17156955a84122a' '5fa=
7d739f811bdffb5fc99696c2e821344fe0b88' '63b4c34635cf32af023796b64c855dd1ed0=
f0a4f' 'f98cabe3f6cf6396b3ae0264800d9b53d7612433' 'ad4728740bd68d74365a43ac=
c25a65339a9b2173' '46c8b4d2a693eca69a2191436cffa44f489e98c7' 'e336ab509b43e=
a601801dfa05b4270023c3ed007' '878702702dbbd933a5da601c75b8e58eadeec311' '2c=
618f361ae6b9da7fafafc289051728ef4c6ea3' '20253f806818e9a1657a832ebcf4141d0a=
08c02a' 'cb3c715d89607f8896c0f20fe528a08e7ebffea9' '2aa28b748fc967a2f2566c0=
6bdad155fba8af7d8' '0266f9541038b9b98ddd387132b5bdfe32a304e3' '0f67557763ac=
cbdd56681f17ed5350735198c57b' 'a24802b0a2a238eaa610b0b0e87a4500a35de64a' 'a=
be962346ef420998d47ba1c2fe591582f69e92e' 'ab63e9910d2d3ea4b8e6c08812258a676=
defcb9c' '8d7de4a014f589c1776959f7fdadbf7b12045aac' '88d0d17192c5a850dc07bb=
38035b69c4cefde270' '8b84d712ad849172f6bbcad57534b284d942b0b5' '6a1f303cba4=
5fa3b612d5a2898b1b1b045eb74e3' '4d906371d1f9fc9ce47b2c8f37444680246557bc' '=
f8527a29f4619f74bc30a9845ea87abb9a6faa1e' '8b184c34806e5da4d4847fabd3faeff3=
8b47e70a' '18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4' '1217b573978482ae7d21d=
c5c0bf5aa5007b24f90' '59ba108806516adeaed51a536d55d4f5e9645881' '30db1b21fa=
37a2f37c7f4d71864405a05e889833' '2e0fd4583d0efcdc260e61a22666c8368f505353' =
'6a129b2ca5c533aec89fbeb58470811cc4102642' 'd9e33b38c89f4cf8c32b8481dbcf3a6=
cdbba4595' 'e5b4ad2183f7ab18aaf7c73a120d17241ee58e97' '1cf87861a2e02432fb68=
f8bcc8f20a8e42acde59' '5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5' '4336efb59=
ef364e691ef829a73d9dbd4d5ed7c7b' '2c625f0fe2db4e6a58877ce2318df3aa312eb791'=
 '7d083666123a425ba9f81dff1a52955b1f226540' 'b497e1a1a2b10c4ddb28064fba2293=
65ae03311a' '9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634' '0ccc1eeda155c947d88=
ef053e0b54e434e218ee2' '7748328c2fd82efed24257b2bfd796eb1fa1d09b' 'dd7ae5b8=
b3c291c0206f127a564ae1e316705ca0' '5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd=
' '94b39cb3ad6db935b585988b36378884199cd5fc' '06dd3eda0e958cdae48ca755eb504=
7484f678d78' 'ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c' 'ce57b718006a069226=
b5e5d3afe7969acd59154e' '3279052eab235bfb7130b1fabc74029c2260ed8d' '8f57dcf=
39fd0864f5f3e6701fe885e55f45d0d3a' '9d35d068fb138160709e04e3ee97fe29a6f8615=
b' '8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb' '3d439e1ec3368fae17db379354bd=
7a9e568ca0ab' '5c39bc498f5ff7ef016abf3f16698f3e8db79677' '07752abfa5dbf7cb4=
d9ce69fa94dc3b12bc597d9' 'f7c41911ad744177d8289820f01009dc93d8f91c' 'd57d27=
171c92e9049d5301785fb38de127b28fbf' 'f522da9ab56c96db8703b2ea0f09be7cdc3bff=
eb' 'c42e36a488c7e01f833fc9f4814f735b66b2d494' 'a37280daa4d583c7212681c49b2=
85de9464a5200' 'b088b6189a4066b97cef459afd312fd168a76dea' 'ff9a7857b7848227=
788f113d6dc6a72e989084e0' 'f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c' 'edb5c=
1f885207d1d74e8a1528e6937e02829ee6e' 'e2ab5f600bb01d3625d667d97b3eb7538e388=
336' '11f5c5f9e43e9020bae452232983fe98e7abfce0' '5b4dcaf851df8c414bfc2ac3bf=
9c65fc942f3be4' '899fb38dd76dd3ede425bbaf8a96d390180a5d1c' 'a12b74d2bd4724e=
e1883bc97ec93eac8fafc8d3c' 'f840737d1746398c2993be34bfdc80bdc19ecae2' 'd78e=
48ebe04e9566f8ecbf51471e80da3adbceeb' '96bcb34df55f7fee99795127c796315950c9=
4fed' 'c232495d28ca092d0c39b10e35d3d613bd2414ab' 'ec0be3cdf40b5302248f3fb27=
a911cc630e8b855' '27848c082ba0b22850fd9fb7b185c015423dcdc7' 'da9881d00153cc=
6d3917f6b74144b1d41b58338c' 'c1dd310f1d76b4b13f1854618087af2513140897' 'cf6=
5182247761f7993737b710afe8c781699356b' '550bc517e59347b3b1af7d290eac4fb1411=
a3d4e' '2a55135201d5e24b80b7624880ff42eafd8e320c' 'daf855f76a1210ceed9541f7=
1ac5dd9be02018a6' '0056b410355713556d8a10306f82e55b28d33ba8' '90179609efa42=
1b1ccc7d8eafbc078bafb25777c' '48124569bbc6bfda1df3e9ee17b19d559f4b1aa3' '25=
8384d8ce365dddd6c5c15204de8ccd53a7ab0a' '6d068f1ae2a2f713d7f21a9a602e65b3d6=
b6fc6d' '37533933bfe92cd5a99ef4743f31dac62ccc8de0' '0e62438e476494a1891a882=
2b9785bc6e73e9c3f' 'a46e95c81e3a28926ab1904d9f754fef8318074d' '5c36b86d2bf6=
8fbcad16169983ef7ee8c537db59' '714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb' '9=
c45f95222beecd6a284fd1284d54dd7a772cf59' 'bab4ab484a6ca170847da9bffe86f1fa9=
0df4bbe' 'b832b19318534bb4f1673b24d78037fee339c679' '8c02c8353460f8630313ae=
f6810f34e134a3c1ee' '6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1' 'a54ef141885=
19a0994d0264f701f5771815fa11e' '2291a2186305faaf8525d57849d8ba12ad63f5e7' '=
595b7f155b926460a00776cc581e4dcd01220006' 'cf25eb8eae91bcae9b2065d84b0c0ba0=
f6d9dd34' 'a1d0b0ae65ae3f32597edfbb547f16c75601cd87' '3059067fd3378a5454e79=
28c08d20bf3ef186760' '9a200cbdb54349909a42b45379e792e4b39dd223' '2d86d2585a=
b929a143d1e6f8963da1499e33bf13' '886f42ce96e7ce80545704e7168a9c6b60cd6c03' =
'162e23657e5379f07c6404dbfbf4367cb438ea7d'
# test job: [e609438851928381e39b5393f17156955a84122a] https://lava.sirena.=
org.uk/scheduler/job/1868298
# test job: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] https://lava.sirena.=
org.uk/scheduler/job/1868334
# test job: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] https://lava.sirena.=
org.uk/scheduler/job/1863533
# test job: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] https://lava.sirena.=
org.uk/scheduler/job/1862338
# test job: [ad4728740bd68d74365a43acc25a65339a9b2173] https://lava.sirena.=
org.uk/scheduler/job/1862573
# test job: [46c8b4d2a693eca69a2191436cffa44f489e98c7] https://lava.sirena.=
org.uk/scheduler/job/1862020
# test job: [e336ab509b43ea601801dfa05b4270023c3ed007] https://lava.sirena.=
org.uk/scheduler/job/1862904
# test job: [878702702dbbd933a5da601c75b8e58eadeec311] https://lava.sirena.=
org.uk/scheduler/job/1863785
# test job: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] https://lava.sirena.=
org.uk/scheduler/job/1850254
# test job: [20253f806818e9a1657a832ebcf4141d0a08c02a] https://lava.sirena.=
org.uk/scheduler/job/1848543
# test job: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] https://lava.sirena.=
org.uk/scheduler/job/1847548
# test job: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] https://lava.sirena.=
org.uk/scheduler/job/1848330
# test job: [0266f9541038b9b98ddd387132b5bdfe32a304e3] https://lava.sirena.=
org.uk/scheduler/job/1848801
# test job: [0f67557763accbdd56681f17ed5350735198c57b] https://lava.sirena.=
org.uk/scheduler/job/1848729
# test job: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] https://lava.sirena.=
org.uk/scheduler/job/1847555
# test job: [abe962346ef420998d47ba1c2fe591582f69e92e] https://lava.sirena.=
org.uk/scheduler/job/1840595
# test job: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] https://lava.sirena.=
org.uk/scheduler/job/1838208
# test job: [8d7de4a014f589c1776959f7fdadbf7b12045aac] https://lava.sirena.=
org.uk/scheduler/job/1833226
# test job: [88d0d17192c5a850dc07bb38035b69c4cefde270] https://lava.sirena.=
org.uk/scheduler/job/1833988
# test job: [8b84d712ad849172f6bbcad57534b284d942b0b5] https://lava.sirena.=
org.uk/scheduler/job/1834038
# test job: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] https://lava.sirena.=
org.uk/scheduler/job/1830431
# test job: [4d906371d1f9fc9ce47b2c8f37444680246557bc] https://lava.sirena.=
org.uk/scheduler/job/1832438
# test job: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] https://lava.sirena.=
org.uk/scheduler/job/1832502
# test job: [8b184c34806e5da4d4847fabd3faeff38b47e70a] https://lava.sirena.=
org.uk/scheduler/job/1829207
# test job: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] https://lava.sirena.=
org.uk/scheduler/job/1829155
# test job: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] https://lava.sirena.=
org.uk/scheduler/job/1809957
# test job: [59ba108806516adeaed51a536d55d4f5e9645881] https://lava.sirena.=
org.uk/scheduler/job/1809987
# test job: [30db1b21fa37a2f37c7f4d71864405a05e889833] https://lava.sirena.=
org.uk/scheduler/job/1811004
# test job: [2e0fd4583d0efcdc260e61a22666c8368f505353] https://lava.sirena.=
org.uk/scheduler/job/1806809
# test job: [6a129b2ca5c533aec89fbeb58470811cc4102642] https://lava.sirena.=
org.uk/scheduler/job/1805765
# test job: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] https://lava.sirena.=
org.uk/scheduler/job/1806672
# test job: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] https://lava.sirena.=
org.uk/scheduler/job/1799495
# test job: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] https://lava.sirena.=
org.uk/scheduler/job/1795064
# test job: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] https://lava.sirena.=
org.uk/scheduler/job/1795963
# test job: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] https://lava.sirena.=
org.uk/scheduler/job/1795901
# test job: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] https://lava.sirena.=
org.uk/scheduler/job/1794545
# test job: [7d083666123a425ba9f81dff1a52955b1f226540] https://lava.sirena.=
org.uk/scheduler/job/1794830
# test job: [b497e1a1a2b10c4ddb28064fba229365ae03311a] https://lava.sirena.=
org.uk/scheduler/job/1780236
# test job: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] https://lava.sirena.=
org.uk/scheduler/job/1779444
# test job: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] https://lava.sirena.=
org.uk/scheduler/job/1773056
# test job: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] https://lava.sirena.=
org.uk/scheduler/job/1773396
# test job: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] https://lava.sirena.=
org.uk/scheduler/job/1773239
# test job: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] https://lava.sirena.=
org.uk/scheduler/job/1769271
# test job: [94b39cb3ad6db935b585988b36378884199cd5fc] https://lava.sirena.=
org.uk/scheduler/job/1768632
# test job: [06dd3eda0e958cdae48ca755eb5047484f678d78] https://lava.sirena.=
org.uk/scheduler/job/1832033
# test job: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] https://lava.sirena.=
org.uk/scheduler/job/1768996
# test job: [ce57b718006a069226b5e5d3afe7969acd59154e] https://lava.sirena.=
org.uk/scheduler/job/1768710
# test job: [3279052eab235bfb7130b1fabc74029c2260ed8d] https://lava.sirena.=
org.uk/scheduler/job/1762434
# test job: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] https://lava.sirena.=
org.uk/scheduler/job/1760117
# test job: [9d35d068fb138160709e04e3ee97fe29a6f8615b] https://lava.sirena.=
org.uk/scheduler/job/1758668
# test job: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] https://lava.sirena.=
org.uk/scheduler/job/1758573
# test job: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] https://lava.sirena.=
org.uk/scheduler/job/1753483
# test job: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] https://lava.sirena.=
org.uk/scheduler/job/1751941
# test job: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] https://lava.sirena.=
org.uk/scheduler/job/1752234
# test job: [f7c41911ad744177d8289820f01009dc93d8f91c] https://lava.sirena.=
org.uk/scheduler/job/1752282
# test job: [d57d27171c92e9049d5301785fb38de127b28fbf] https://lava.sirena.=
org.uk/scheduler/job/1752640
# test job: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] https://lava.sirena.=
org.uk/scheduler/job/1751874
# test job: [c42e36a488c7e01f833fc9f4814f735b66b2d494] https://lava.sirena.=
org.uk/scheduler/job/1746243
# test job: [a37280daa4d583c7212681c49b285de9464a5200] https://lava.sirena.=
org.uk/scheduler/job/1746913
# test job: [b088b6189a4066b97cef459afd312fd168a76dea] https://lava.sirena.=
org.uk/scheduler/job/1746192
# test job: [ff9a7857b7848227788f113d6dc6a72e989084e0] https://lava.sirena.=
org.uk/scheduler/job/1746337
# test job: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] https://lava.sirena.=
org.uk/scheduler/job/1747888
# test job: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] https://lava.sirena.=
org.uk/scheduler/job/1746128
# test job: [e2ab5f600bb01d3625d667d97b3eb7538e388336] https://lava.sirena.=
org.uk/scheduler/job/1746591
# test job: [11f5c5f9e43e9020bae452232983fe98e7abfce0] https://lava.sirena.=
org.uk/scheduler/job/1747485
# test job: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] https://lava.sirena.=
org.uk/scheduler/job/1747668
# test job: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] https://lava.sirena.=
org.uk/scheduler/job/1747385
# test job: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] https://lava.sirena.=
org.uk/scheduler/job/1734043
# test job: [f840737d1746398c2993be34bfdc80bdc19ecae2] https://lava.sirena.=
org.uk/scheduler/job/1727325
# test job: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] https://lava.sirena.=
org.uk/scheduler/job/1706193
# test job: [96bcb34df55f7fee99795127c796315950c94fed] https://lava.sirena.=
org.uk/scheduler/job/1699558
# test job: [c232495d28ca092d0c39b10e35d3d613bd2414ab] https://lava.sirena.=
org.uk/scheduler/job/1699583
# test job: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] https://lava.sirena.=
org.uk/scheduler/job/1694320
# test job: [27848c082ba0b22850fd9fb7b185c015423dcdc7] https://lava.sirena.=
org.uk/scheduler/job/1693115
# test job: [da9881d00153cc6d3917f6b74144b1d41b58338c] https://lava.sirena.=
org.uk/scheduler/job/1693374
# test job: [c1dd310f1d76b4b13f1854618087af2513140897] https://lava.sirena.=
org.uk/scheduler/job/1692987
# test job: [cf65182247761f7993737b710afe8c781699356b] https://lava.sirena.=
org.uk/scheduler/job/1687545
# test job: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] https://lava.sirena.=
org.uk/scheduler/job/1685911
# test job: [2a55135201d5e24b80b7624880ff42eafd8e320c] https://lava.sirena.=
org.uk/scheduler/job/1685795
# test job: [daf855f76a1210ceed9541f71ac5dd9be02018a6] https://lava.sirena.=
org.uk/scheduler/job/1685505
# test job: [0056b410355713556d8a10306f82e55b28d33ba8] https://lava.sirena.=
org.uk/scheduler/job/1685609
# test job: [90179609efa421b1ccc7d8eafbc078bafb25777c] https://lava.sirena.=
org.uk/scheduler/job/1686053
# test job: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] https://lava.sirena.=
org.uk/scheduler/job/1670178
# test job: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] https://lava.sirena.=
org.uk/scheduler/job/1673374
# test job: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] https://lava.sirena.=
org.uk/scheduler/job/1673136
# test job: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] https://lava.sirena.=
org.uk/scheduler/job/1668972
# test job: [0e62438e476494a1891a8822b9785bc6e73e9c3f] https://lava.sirena.=
org.uk/scheduler/job/1669548
# test job: [a46e95c81e3a28926ab1904d9f754fef8318074d] https://lava.sirena.=
org.uk/scheduler/job/1673781
# test job: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] https://lava.sirena.=
org.uk/scheduler/job/1668601
# test job: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] https://lava.sirena.=
org.uk/scheduler/job/1667730
# test job: [9c45f95222beecd6a284fd1284d54dd7a772cf59] https://lava.sirena.=
org.uk/scheduler/job/1667595
# test job: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] https://lava.sirena.=
org.uk/scheduler/job/1664669
# test job: [b832b19318534bb4f1673b24d78037fee339c679] https://lava.sirena.=
org.uk/scheduler/job/1659221
# test job: [8c02c8353460f8630313aef6810f34e134a3c1ee] https://lava.sirena.=
org.uk/scheduler/job/1659272
# test job: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] https://lava.sirena.=
org.uk/scheduler/job/1656576
# test job: [a54ef14188519a0994d0264f701f5771815fa11e] https://lava.sirena.=
org.uk/scheduler/job/1656018
# test job: [2291a2186305faaf8525d57849d8ba12ad63f5e7] https://lava.sirena.=
org.uk/scheduler/job/1655765
# test job: [595b7f155b926460a00776cc581e4dcd01220006] https://lava.sirena.=
org.uk/scheduler/job/1653110
# test job: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] https://lava.sirena.=
org.uk/scheduler/job/1654803
# test job: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] https://lava.sirena.=
org.uk/scheduler/job/1654219
# test job: [3059067fd3378a5454e7928c08d20bf3ef186760] https://lava.sirena.=
org.uk/scheduler/job/1653991
# test job: [9a200cbdb54349909a42b45379e792e4b39dd223] https://lava.sirena.=
org.uk/scheduler/job/1654737
# test job: [2d86d2585ab929a143d1e6f8963da1499e33bf13] https://lava.sirena.=
org.uk/scheduler/job/1655874
# test job: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] https://lava.sirena.=
org.uk/scheduler/job/1654309
# test job: [162e23657e5379f07c6404dbfbf4367cb438ea7d] https://lava.sirena.=
org.uk/scheduler/job/1652988
# test job: [b5a4da2c459f79a2c87c867398f1c0c315779781] https://lava.sirena.=
org.uk/scheduler/job/1882244
# bad: [b5a4da2c459f79a2c87c867398f1c0c315779781] Add linux-next specific f=
iles for 20250924
git bisect bad b5a4da2c459f79a2c87c867398f1c0c315779781
# test job: [0472b4c78c217f5ee557b636857bce6a4417fb66] https://lava.sirena.=
org.uk/scheduler/job/1882666
# bad: [0472b4c78c217f5ee557b636857bce6a4417fb66] Merge branch 'main' of ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 0472b4c78c217f5ee557b636857bce6a4417fb66
# test job: [6610ba341bd7cfeb4cc00d0365c82b4ce961d4cb] https://lava.sirena.=
org.uk/scheduler/job/1882922
# bad: [6610ba341bd7cfeb4cc00d0365c82b4ce961d4cb] Merge branch 'fs-next' of=
 linux-next
git bisect bad 6610ba341bd7cfeb4cc00d0365c82b4ce961d4cb
# skip: [7d14bf61ad6bcfd7063346d41bf728f3c358b144] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect skip 7d14bf61ad6bcfd7063346d41bf728f3c358b144
# test job: [3e6db854a22e728b58ed2ef200495521a89ad6e1] https://lava.sirena.=
org.uk/scheduler/job/1883359
# good: [3e6db854a22e728b58ed2ef200495521a89ad6e1] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
git bisect good 3e6db854a22e728b58ed2ef200495521a89ad6e1
# test job: [a22a9e1271fb505f2c85d526d05aad5dde2f50e1] https://lava.sirena.=
org.uk/scheduler/job/1883508
# good: [a22a9e1271fb505f2c85d526d05aad5dde2f50e1] ARM: dts: imx6ul-tx6ul: =
Switch away from deprecated `phy-reset-gpios`
git bisect good a22a9e1271fb505f2c85d526d05aad5dde2f50e1
# test job: [ae014fbc99c7f986ee785233e7a5336834e39af4] https://lava.sirena.=
org.uk/scheduler/job/1883688
# good: [ae014fbc99c7f986ee785233e7a5336834e39af4] arm64: dts: renesas: rzg=
2lc-smarc: Disable CAN-FD channel0
git bisect good ae014fbc99c7f986ee785233e7a5336834e39af4
# skip: [5fc6bef178f1b644f1439e520c8f83bfc83a1252] cgroup: split namespace =
into separate header
git bisect skip 5fc6bef178f1b644f1439e520c8f83bfc83a1252
# skip: [2b8b848817ef69f59a9bf6846a44b9f8809a7875] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git
git bisect skip 2b8b848817ef69f59a9bf6846a44b9f8809a7875
# test job: [aac9b7716efe1815a2026ba6c3d4a3d10b39fd0f] https://lava.sirena.=
org.uk/scheduler/job/1883993
# skip: [aac9b7716efe1815a2026ba6c3d4a3d10b39fd0f] scsi: Always define blog=
ic_pci_tbl structure
git bisect skip aac9b7716efe1815a2026ba6c3d4a3d10b39fd0f
# test job: [ab6d91d141a801dadf9eed7860b2ea09c9268149] https://lava.sirena.=
org.uk/scheduler/job/1884076
# good: [ab6d91d141a801dadf9eed7860b2ea09c9268149] dt-bindings: clock: gcc-=
sdm660: Add LPASS/CDSP vote clocks/GDSCs
git bisect good ab6d91d141a801dadf9eed7860b2ea09c9268149
# test job: [2742d963e1dd7f4a3d0505044323b091daffcddc] https://lava.sirena.=
org.uk/scheduler/job/1884218
# good: [2742d963e1dd7f4a3d0505044323b091daffcddc] arm64: dts: ti: k3-j784s=
4-ti-ipc-firmware: Refactor IPC cfg into new dtsi
git bisect good 2742d963e1dd7f4a3d0505044323b091daffcddc
# test job: [bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd] https://lava.sirena.=
org.uk/scheduler/job/1884384
# good: [bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd] arm64: dts: qcom: sm8550=
: move dp0 data-lanes to SoC dtsi
git bisect good bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd
# test job: [55b7522ef2e142964595a73cc2ec0b704a353dc6] https://lava.sirena.=
org.uk/scheduler/job/1884699
# good: [55b7522ef2e142964595a73cc2ec0b704a353dc6] mm/vma: rename __mmap_pr=
epare() function to avoid confusion
git bisect good 55b7522ef2e142964595a73cc2ec0b704a353dc6
# test job: [46961265bdfb9c237cb03ea6b640b8e7588a982a] https://lava.sirena.=
org.uk/scheduler/job/1884880
# good: [46961265bdfb9c237cb03ea6b640b8e7588a982a] arm64: dts: fsl-ls1046a:=
 Add default GIC address cells
git bisect good 46961265bdfb9c237cb03ea6b640b8e7588a982a
# test job: [abfbfb98acfe6fd603d48424e32f8d99922e70b9] https://lava.sirena.=
org.uk/scheduler/job/1885006
# good: [abfbfb98acfe6fd603d48424e32f8d99922e70b9] Merge tag 'amlogic-arm64=
-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/l=
inux into soc/dt
git bisect good abfbfb98acfe6fd603d48424e32f8d99922e70b9
# test job: [5c3d22b9ba905785648ff7117f86787f41d899bd] https://lava.sirena.=
org.uk/scheduler/job/1885153
# good: [5c3d22b9ba905785648ff7117f86787f41d899bd] Merge branch 'for-next' =
of https://github.com/Xilinx/linux-xlnx.git
git bisect good 5c3d22b9ba905785648ff7117f86787f41d899bd
# test job: [c54644c3221b6230a9fc0f9f09630b4ef7a6bd79] https://lava.sirena.=
org.uk/scheduler/job/1885310
# bad: [c54644c3221b6230a9fc0f9f09630b4ef7a6bd79] Merge branch 'for-next' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect bad c54644c3221b6230a9fc0f9f09630b4ef7a6bd79
# test job: [8558791888761953dc60f8d2925f7299e65b2052] https://lava.sirena.=
org.uk/scheduler/job/1885393
# good: [8558791888761953dc60f8d2925f7299e65b2052] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
git bisect good 8558791888761953dc60f8d2925f7299e65b2052
# test job: [a5b2913640341a5260a4b5db20dd2ecf807700f2] https://lava.sirena.=
org.uk/scheduler/job/1885427
# bad: [a5b2913640341a5260a4b5db20dd2ecf807700f2] Merge branch 'vfs-6.18.wr=
iteback' into vfs.all
git bisect bad a5b2913640341a5260a4b5db20dd2ecf807700f2
# test job: [5890f504ef543190beae2a4e244bbfa7c3e0b57c] https://lava.sirena.=
org.uk/scheduler/job/1885602
# good: [5890f504ef543190beae2a4e244bbfa7c3e0b57c] ns: add ns_debug()
git bisect good 5890f504ef543190beae2a4e244bbfa7c3e0b57c
# test job: [7617579235071cb597297ff92c8648dfe712a041] https://lava.sirena.=
org.uk/scheduler/job/1885955
# bad: [7617579235071cb597297ff92c8648dfe712a041] Merge branch 'vfs-6.18.wo=
rkqueue' into vfs.all
git bisect bad 7617579235071cb597297ff92c8648dfe712a041
# test job: [29ecd1ca48ec2bd1761e82d69f76d34411c88eb4] https://lava.sirena.=
org.uk/scheduler/job/1886008
# bad: [29ecd1ca48ec2bd1761e82d69f76d34411c88eb4] Merge branch 'vfs-6.18.mi=
sc' into vfs.all
git bisect bad 29ecd1ca48ec2bd1761e82d69f76d34411c88eb4
# test job: [afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee] https://lava.sirena.=
org.uk/scheduler/job/1886080
# good: [afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee] initramfs: Replace strcp=
y() with strscpy() in find_link()
git bisect good afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee
# test job: [2bc5bfbfd3f27f87e70e840fee6a403051b763fa] https://lava.sirena.=
org.uk/scheduler/job/1886130
# good: [2bc5bfbfd3f27f87e70e840fee6a403051b763fa] statmount: don't call pa=
th_put() under namespace semaphore
git bisect good 2bc5bfbfd3f27f87e70e840fee6a403051b763fa
# test job: [e6524dd4c06824737d6a8f5eb7d0827cbe08a64a] https://lava.sirena.=
org.uk/scheduler/job/1886155
# bad: [e6524dd4c06824737d6a8f5eb7d0827cbe08a64a] fcntl: trim arguments
git bisect bad e6524dd4c06824737d6a8f5eb7d0827cbe08a64a
# test job: [59bfb66816809996618dc4270845036ba02d8837] https://lava.sirena.=
org.uk/scheduler/job/1886305
# bad: [59bfb66816809996618dc4270845036ba02d8837] listmount: don't call pat=
h_put() under namespace semaphore
git bisect bad 59bfb66816809996618dc4270845036ba02d8837
# first bad commit: [59bfb66816809996618dc4270845036ba02d8837] listmount: d=
on't call path_put() under namespace semaphore

--AtzJzu8llHkO1YO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjVMR8ACgkQJNaLcl1U
h9DB+Af+KemaiJmr45oNLd6yblXR3qGBft5OlJb82RQyt5d5CK18EqZwg+7RuHWz
+UJnNmEhGI70IOQwrgkAVYSNS6EJYCRLMt7pzoZCM0XvahUEqzpAyW5uce8sSCbM
LwtTKib1xJHTdv7sdzRox9FxDZeX4at5uRTqMhddX9fS5OBYoVcq8ivSGn4wOEmx
CEJAd02ODByJ1qY6AQj/THO/AvjGmQsWZboneG+1cckkcugxpiMXB1VIIz9T/3fr
bf92ZmVIYwx6+3/Rl+9l1RsPb9kn0VDvyU4nN4MSwg/ZqZKW3bQQD9TVvc5kchKh
NVKe77oAvpDT1vxUltzW2HI58yTikQ==
=Kn7c
-----END PGP SIGNATURE-----

--AtzJzu8llHkO1YO8--

